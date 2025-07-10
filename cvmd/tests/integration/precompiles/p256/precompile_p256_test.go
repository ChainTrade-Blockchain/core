package p256

import (
	"testing"

	"github.com/stretchr/testify/suite"

	"github.com/ChainTrade-Blockchain/core/cvmd/tests/integration"
	"github.com/ChainTrade-Blockchain/core/tests/integration/precompiles/p256"
)

func TestP256PrecompileTestSuite(t *testing.T) {
	s := p256.NewPrecompileTestSuite(integration.CreateEvmd)
	suite.Run(t, s)
}

func TestP256PrecompileIntegrationTestSuite(t *testing.T) {
	p256.TestPrecompileIntegrationTestSuite(t, integration.CreateEvmd)
}
