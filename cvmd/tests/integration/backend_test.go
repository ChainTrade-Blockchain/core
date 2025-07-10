package integration

import (
	"testing"

	"github.com/stretchr/testify/suite"

	"github.com/ChainTrade-Blockchain/core/tests/integration/rpc/backend"
)

func TestBackend(t *testing.T) {
	s := backend.NewTestSuite(CreateEvmd)
	suite.Run(t, s)
}
