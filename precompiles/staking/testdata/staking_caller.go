package testdata

import (
	contractutils "github.com/ChainTrade-Blockchain/core/contracts/utils"
	evmtypes "github.com/ChainTrade-Blockchain/core/x/vm/types"
)

func LoadStakingCallerContract() (evmtypes.CompiledContract, error) {
	return contractutils.LoadContractFromJSONFile("StakingCaller.json")
}
