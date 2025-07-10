package testdata

import (
	contractutils "github.com/ChainTrade-Blockchain/core/contracts/utils"
	evmtypes "github.com/ChainTrade-Blockchain/core/x/vm/types"
)

// LoadWEVMOS9Contract load the WEVMOS9 contract from the json representation of
// the Solidity contract.
func LoadWEVMOS9Contract() (evmtypes.CompiledContract, error) {
	return contractutils.LoadContractFromJSONFile("WEVMOS9.json")
}
