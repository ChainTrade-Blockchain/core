package gov

import (
	"testing"

	"github.com/stretchr/testify/suite"

	"github.com/ChainTrade-Blockchain/core/cvmd/tests/integration"
	"github.com/ChainTrade-Blockchain/core/tests/integration/precompiles/gov"
)

func TestGovPrecompileTestSuite(t *testing.T) {
	s := gov.NewPrecompileTestSuite(integration.CreateEvmd)
	suite.Run(t, s)
}

func TestGovPrecompileIntegrationTestSuite(t *testing.T) {
	gov.TestPrecompileIntegrationTestSuite(t, integration.CreateEvmd)
}
