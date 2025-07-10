package slashing

import (
	"github.com/stretchr/testify/suite"

	"github.com/ChainTrade-Blockchain/core/precompiles/slashing"
	"github.com/ChainTrade-Blockchain/core/testutil/integration/evm/factory"
	"github.com/ChainTrade-Blockchain/core/testutil/integration/evm/grpc"
	"github.com/ChainTrade-Blockchain/core/testutil/integration/evm/network"
	testkeyring "github.com/ChainTrade-Blockchain/core/testutil/keyring"

	sdk "github.com/cosmos/cosmos-sdk/types"
)

type PrecompileTestSuite struct {
	suite.Suite

	create      network.CreateEvmApp
	options     []network.ConfigOption
	network     *network.UnitTestNetwork
	factory     factory.TxFactory
	grpcHandler grpc.Handler
	keyring     testkeyring.Keyring

	precompile *slashing.Precompile
}

func NewPrecompileTestSuite(create network.CreateEvmApp, options ...network.ConfigOption) *PrecompileTestSuite {
	return &PrecompileTestSuite{
		create:  create,
		options: options,
	}
}

func (s *PrecompileTestSuite) SetupTest() {
	keyring := testkeyring.New(3)
	var err error
	options := []network.ConfigOption{
		network.WithPreFundedAccounts(keyring.GetAllAccAddrs()...),
		network.WithValidatorOperators([]sdk.AccAddress{
			keyring.GetAccAddr(0),
			keyring.GetAccAddr(1),
			keyring.GetAccAddr(2),
		}),
	}
	options = append(options, s.options...)
	nw := network.NewUnitTestNetwork(s.create, options...)
	grpcHandler := grpc.NewIntegrationHandler(nw)
	txFactory := factory.New(nw, grpcHandler)

	s.network = nw
	s.factory = txFactory
	s.grpcHandler = grpcHandler
	s.keyring = keyring

	if s.precompile, err = slashing.NewPrecompile(
		s.network.App.GetSlashingKeeper(),
	); err != nil {
		panic(err)
	}
}
