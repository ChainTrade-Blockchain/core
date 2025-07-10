package cvmd

import (
	cmn "github.com/ChainTrade-Blockchain/core/precompiles/common"
	evmtypes "github.com/ChainTrade-Blockchain/core/x/vm/types"
)

type BankKeeper interface {
	evmtypes.BankKeeper
	cmn.BankKeeper
}
