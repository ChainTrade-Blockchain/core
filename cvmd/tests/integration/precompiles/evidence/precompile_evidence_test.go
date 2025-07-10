package evidence

import (
	"testing"

	"github.com/stretchr/testify/suite"

	"github.com/ChainTrade-Blockchain/core/cvmd/tests/integration"
	"github.com/ChainTrade-Blockchain/core/tests/integration/precompiles/evidence"
)

func TestEvidencePrecompileTestSuite(t *testing.T) {
	s := evidence.NewPrecompileTestSuite(integration.CreateEvmd)
	suite.Run(t, s)
}
