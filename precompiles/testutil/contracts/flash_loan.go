package contracts

import (
	contractutils "github.com/ChainTrade-Blockchain/core/contracts/utils"
	evmtypes "github.com/ChainTrade-Blockchain/core/x/vm/types"
)

func LoadFlashLoanContract() (evmtypes.CompiledContract, error) {
	return contractutils.LoadContractFromJSONFile("FlashLoan.json")
}
