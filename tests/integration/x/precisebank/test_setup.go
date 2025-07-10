package precisebank

import (
	"github.com/stretchr/testify/suite"

	testconstants "github.com/ChainTrade-Blockchain/core/testutil/constants"
	"github.com/ChainTrade-Blockchain/core/testutil/integration/evm/factory"
	"github.com/ChainTrade-Blockchain/core/testutil/integration/evm/grpc"
	"github.com/ChainTrade-Blockchain/core/testutil/integration/evm/network"
	"github.com/ChainTrade-Blockchain/core/testutil/keyring"
)

const SEED = int64(42)

type KeeperIntegrationTestSuite struct {
	suite.Suite

	create  network.CreateEvmApp
	options []network.ConfigOption
	network *network.UnitTestNetwork
	factory factory.TxFactory
	keyring keyring.Keyring
}

func NewKeeperIntegrationTestSuite(create network.CreateEvmApp, options ...network.ConfigOption) *KeeperIntegrationTestSuite {
	return &KeeperIntegrationTestSuite{
		create:  create,
		options: options,
	}
}

func (s *KeeperIntegrationTestSuite) SetupTest() {
	s.SetupTestWithChainID(testconstants.SixDecimalsChainID)
}

func (s *KeeperIntegrationTestSuite) SetupTestWithChainID(chainID testconstants.ChainID) {
	s.keyring = keyring.New(2)

	options := []network.ConfigOption{
		network.WithChainID(chainID),
		network.WithPreFundedAccounts(s.keyring.GetAllAccAddrs()...),
	}
	options = append(options, s.options...)
	nw := network.NewUnitTestNetwork(s.create, options...)
	gh := grpc.NewIntegrationHandler(nw)
	tf := factory.New(nw, gh)

	s.network = nw
	s.factory = tf
}
