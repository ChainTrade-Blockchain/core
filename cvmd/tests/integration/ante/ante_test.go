package ante

import (
	"testing"

	"github.com/ChainTrade-Blockchain/core/cvmd/tests/integration"
	"github.com/ChainTrade-Blockchain/core/tests/integration/ante"
)

func TestAnte_Integration(t *testing.T) {
	ante.TestIntegrationAnteHandler(t, integration.CreateEvmd)
}
