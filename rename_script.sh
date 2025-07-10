#!/bin/bash

# --- Configuration ---
OLD_MODULE_BASE="github.com/ChainTrade-Blockchain/core"
OLD_MODULE_DAEMON="github.com/ChainTrade-Blockchain/core/cvmd"

NEW_MODULE_BASE="github.com/ChainTrade-Blockchain/core"
NEW_MODULE_DAEMON="github.com/ChainTrade-Blockchain/core/cvmd"


# --- Main Script ---
set -e # Exit immediately if a command exits with a non-zero status.

echo "Starting replacement script..."

# This script uses a loop which is more compatible with macOS sed.
# It sets LC_ALL=C to prevent "illegal byte sequence" errors.

echo "1. Replacing daemon module path: $OLD_MODULE_DAEMON -> $NEW_MODULE_DAEMON"
find . -type f -not -path './.git/*' | while read -r file; do
    LC_ALL=C sed -i '' "s|$OLD_MODULE_DAEMON|$NEW_MODULE_DAEMON|g" "$file"
done

echo "2. Replacing base module path: $OLD_MODULE_BASE -> $NEW_MODULE_BASE"
find . -type f -not -path './.git/*' | while read -r file; do
    LC_ALL=C sed -i '' "s|$OLD_MODULE_BASE|$NEW_MODULE_BASE|g" "$file"
done

echo "-----------------------------------------------------"
echo "✅ Replacements complete."
echo "IMPORTANT: Now you must run 'go mod tidy' to update your dependencies."
echo "-----------------------------------------------------"