package testdata

import (
	contractutils "github.com/ChainTrade-Blockchain/core/contracts/utils"
	evmtypes "github.com/ChainTrade-Blockchain/core/x/vm/types"
)

func LoadERC20AllowanceCaller() (evmtypes.CompiledContract, error) {
	return contractutils.LoadContractFromJSONFile("ERC20AllowanceCaller.json")
}
