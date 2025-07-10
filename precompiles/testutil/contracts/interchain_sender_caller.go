package contracts

import (
	contractutils "github.com/ChainTrade-Blockchain/core/contracts/utils"
	evmtypes "github.com/ChainTrade-Blockchain/core/x/vm/types"
)

func LoadInterchainSenderCallerContract() (evmtypes.CompiledContract, error) {
	return contractutils.LoadContractFromJSONFile("InterchainSenderCaller.json")
}
