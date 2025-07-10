package integration

import (
	"testing"

	"github.com/ChainTrade-Blockchain/core/tests/integration/indexer"
)

func TestKVIndexer(t *testing.T) {
	indexer.TestKVIndexer(t, CreateEvmd)
}
