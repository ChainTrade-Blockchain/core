#!/bin/bash

RPC_URL="http://localhost:8545"

echo "Testing EVM RPC ($RPC_URL)..."

echo "1. Client Version:"
cast rpc --rpc-url $RPC_URL web3_clientVersion || echo "Failed to get client version"

echo "2. Chain ID:"
cast chain-id --rpc-url $RPC_URL || echo "Failed to get chain ID"

echo "3. Block Number:"
cast block-number --rpc-url $RPC_URL || echo "Failed to get block number"

echo "4. Latest Block:"
cast block latest --rpc-url $RPC_URL | jq .number || echo "Failed to get latest block"

# Optional: Test balance for a known address
# echo "5. Balance for <YOUR_ADDRESS>:"
# cast balance <YOUR_ADDRESS> --rpc-url $RPC_URL || echo "Failed to get balance"