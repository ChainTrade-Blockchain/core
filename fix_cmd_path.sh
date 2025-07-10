#!/bin/bash

# --- Configuration ---
OLD_PATH="github.com/ChainTrade-Blockchain/core/cvmd/cmd/cvmd"
NEW_PATH="github.com/ChainTrade-Blockchain/core/cvmd/cmd/cvmd"

# --- Main Script ---
set -e # Exit immediately if a command exits with a non-zero status.

echo "Replacing command path..."
echo "From: $OLD_PATH"
echo "To:   $NEW_PATH"

# This find command pipes results to a while loop for better macOS compatibility.
# LC_ALL=C prevents "illegal byte sequence" errors with sed on macOS.
find . -type f -not -path './.git/*' | while read -r file; do
    LC_ALL=C sed -i '' "s|$OLD_PATH|$NEW_PATH|g" "$file"
done

echo "---------------------------"
echo "✅ Path replacement complete."
echo "Run 'go mod tidy' if needed."
echo "---------------------------"