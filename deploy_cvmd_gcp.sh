#!/bin/bash

CHAINID="${CHAIN_ID:-306091}"
MONIKER="chaintrade-testnet"
KEYRING="file"  # Use 'file' keyring for production security
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
HOMEDIR="/var/cvmd"
BASEFEE=10000000
CONFIG=$HOMEDIR/config/config.toml
APP_TOML=$HOMEDIR/config/app.toml
GENESIS=$HOMEDIR/config/genesis.json
TMP_GENESIS=$HOMEDIR/config/tmp_genesis.json

# Create home directory
sudo mkdir -p $HOMEDIR
sudo chown $USER:$USER $HOMEDIR

# Validate jq
command -v jq >/dev/null 2>&1 || { echo >&2 "jq not installed"; exit 1; }

set -e

# Initialize node
cvmd config set client chain-id "$CHAINID" --home "$HOMEDIR"
cvmd config set client keyring-backend "$KEYRING" --home "$HOMEDIR"

# Import keys (use secure storage for production)
VAL_KEY="mykey"
VAL_MNEMONIC="gesture inject test cycle original hollow east ridge hen combine junk child bacon zero hope comfort vacuum milk pitch cage oppose unhappy lunar seat"
USER1_KEY="dev0"
USER1_MNEMONIC="copper push brief egg scan entry inform record adjust fossil boss egg comic alien upon aspect dry avoid interest fury window hint race symptom"
USER2_KEY="dev1"
USER2_MNEMONIC="maximum display century economy unlock van census kite error heart snow filter midnight usage egg venture cash kick motor survey drastic edge muffin visual"
USER3_KEY="dev2"
USER3_MNEMONIC="will wear settle write dance topic tape sea glory hotel oppose rebel client problem era video gossip glide during yard balance cancel file rose"
USER4_KEY="dev3"
USER4_MNEMONIC="doll midnight silk carpet brush boring pluck office gown inquiry duck chief aim exit gain never tennis crime fragile ship cloud surface exotic patch"

echo "$VAL_MNEMONIC" | cvmd keys add "$VAL_KEY" --recover --keyring-backend "$KEYRING" --algo "$KEYALGO" --home "$HOMEDIR"
echo "$USER1_MNEMONIC" | cvmd keys add "$USER1_KEY" --recover --keyring-backend "$KEYRING" --algo "$KEYALGO" --home "$HOMEDIR"
echo "$USER2_MNEMONIC" | cvmd keys add "$USER2_KEY" --recover --keyring-backend "$KEYRING" --algo "$KEYALGO" --home "$HOMEDIR"
echo "$USER3_MNEMONIC" | cvmd keys add "$USER3_KEY" --recover --keyring-backend "$KEYRING" --algo "$KEYALGO" --home "$HOMEDIR"
echo "$USER4_MNEMONIC" | cvmd keys add "$USER4_KEY" --recover --keyring-backend "$KEYRING" --algo "$KEYALGO" --home "$HOMEDIR"

# Initialize chain
cvmd init $MONIKER -o --chain-id "$CHAINID" --home "$HOMEDIR"

# Modify genesis file (same as local script)
jq '.app_state["staking"]["params"]["bond_denom"]="achaintrade"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="achaintrade"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["gov"]["params"]["min_deposit"][0]["denom"]="achaintrade"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["gov"]["params"]["expedited_min_deposit"][0]["denom"]="achaintrade"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["evm"]["params"]["evm_denom"]="achaintrade"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["mint"]["params"]["mint_denom"]="achaintrade"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["bank"]["denom_metadata"]=[{"description":"The native staking token for cvmd.","denom_units":[{"denom":"achaintrade","exponent":0,"aliases":["CHTR"]},{"denom":"chaintrade","exponent":18,"aliases":[]}],"base":"achaintrade","display":"chaintrade","name":"ChainTrade Token","symbol":"CHTR","uri":"https://www.chaintrade.network/icon-2.jpg","uri_hash":""}]' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state["evm"]["params"]["active_static_precompiles"]=["0x0000000000000000000000000000000000000100","0x0000000000000000000000000000000000000400","0x0000000000000000000000000000000000000800","0x0000000000000000000000000000000000000801","0x0000000000000000000000000000000000000802","0x0000000000000000000000000000000000000803","0x0000000000000000000000000000000000000804","0x0000000000000000000000000000000000000805"]' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state.erc20.params.native_precompiles=["0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"]' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.app_state.erc20.token_pairs=[{contract_owner:1,erc20_address:"0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE",denom:"achaintrade",enabled:true}]' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"
jq '.consensus.params.block.max_gas="10000000"' "$GENESIS" >"$TMP_GENESIS" && mv "$TMP_GENESIS" "$GENESIS"

# Configure timeouts (optional, adjust for production)
sed -i 's/timeout_propose = "3s"/timeout_propose = "10s"/g' "$CONFIG"
sed -i 's/timeout_commit = "5s"/timeout_commit = "30s"/g' "$CONFIG"

# Enable Prometheus and APIs
sed -i 's/prometheus = false/prometheus = true/' "$CONFIG"
sed -i 's/prometheus-retention-time  = "0"/prometheus-retention-time  = "1000000000000"/g' "$APP_TOML"
sed -i 's/enabled = false/enabled = true/g' "$APP_TOML"
sed -i 's/enable = false/enable = true/g' "$APP_TOML"

# Set pruning settings
sed -i 's/pruning = "default"/pruning = "custom"/g' "$APP_TOML"
sed -i 's/pruning-keep-recent = "0"/pruning-keep-recent = "100"/g' "$APP_TOML"
sed -i 's/pruning-interval = "0"/pruning-interval = "10"/g' "$APP_TOML"

# Allocate genesis accounts
cvmd genesis add-genesis-account "$VAL_KEY" 100000000000000000000000000achaintrade --keyring-backend "$KEYRING" --home "$HOMEDIR"
cvmd genesis add-genesis-account "$USER1_KEY" 1000000000000000000000achaintrade --keyring-backend "$KEYRING" --home "$HOMEDIR"
cvmd genesis add-genesis-account "$USER2_KEY" 1000000000000000000000achaintrade --keyring-backend "$KEYRING" --home "$HOMEDIR"
cvmd genesis add-genesis-account "$USER3_KEY" 1000000000000000000000achaintrade --keyring-backend "$KEYRING" --home "$HOMEDIR"
cvmd genesis add-genesis-account "$USER4_KEY" 1000000000000000000000achaintrade --keyring-backend "$KEYRING" --home "$HOMEDIR"

# Sign genesis transaction
cvmd genesis gentx "$VAL_KEY" 1000000000000000000000achaintrade --gas-prices ${BASEFEE}achaintrade --keyring-backend "$KEYRING" --chain-id "$CHAINID" --home "$HOMEDIR"

# Collect genesis transactions
cvmd genesis collect-gentxs --home "$HOMEDIR"

# Validate genesis
cvmd genesis validate-genesis --home "$HOMEDIR"