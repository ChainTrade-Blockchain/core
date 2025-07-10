package bank

import (
	"testing"

	"github.com/stretchr/testify/suite"

	"github.com/ChainTrade-Blockchain/core/cvmd/tests/integration"
	"github.com/ChainTrade-Blockchain/core/tests/integration/precompiles/bank"
)

func TestBankPrecompileTestSuite(t *testing.T) {
	s := bank.NewPrecompileTestSuite(integration.CreateEvmd)
	suite.Run(t, s)
}

func TestBankPrecompileIntegrationTestSuite(t *testing.T) {
	bank.TestIntegrationSuite(t, integration.CreateEvmd)
}
