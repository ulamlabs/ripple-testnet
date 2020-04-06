#!/bin/bash
DEFAULT_VALIDATOR_PUBKEY="nHBmGWzxp5Uwo27xETAazV1BXYK7TNoCRhjykRAsTL4nZxGueKFd"
DEFAULT_VALIDATOR_TOKEN="eyJtYW5pZmVzdCI6IkpBQUFBQUZ4SWUwMkhHQkJiaTRTVHV1R3o0a0F4QkFHKzFOQTJia1g1USs2c2RoamFRTDliWE1oQS92ejQwNU54NVNtNkRJVXF1emRyTkRMMitZK2Q4cVU2WS9yb25lSlVUTDVka1l3UkFJZ2U1ZDExUm1KbEY3R251K0k4Y2tsUWU4MnRZejRYYkhyZ2FHRXJKbnNuS2tDSUIvbzRyWXBFTENtbVZ2emg4QWI5WG9ZN2d0dHJ2ZlFwOWNqQklYcW8xZWpjQkpBekFjc0Frc0ZkekROdGY0aEpkSnUvUjhwZ3NDK3pXMDdOenlydlZjRmtMK0tQVDdkNTdOdmJEV1Y5aDBra0VXVWgwZEloVHljRktBR1JTQlZDK2tRRHc9PSIsInZhbGlkYXRpb25fc2VjcmV0X2tleSI6IjcyMzU1RjZFMTBDODY1M0M2MTkzNjdBMDA0QzhGNUE5MzMzRkQxRDE5ODNCOTMzODg2MjM5MUNDRjQzMkIyQUMifQ=="
DEFAULT_NETWORK_ID="11213711"

sed -i "s|RIPPLE_VALIDATOR_TOKEN|${RIPPLE_VALIDATOR_TOKEN:-$DEFAULT_VALIDATOR_TOKEN}|g" /opt/ripple/etc/rippled.cfg
sed -i "s|RIPPLE_NETWORK_ID|${RIPPLE_NETWORK_ID:-$DEFAULT_NETWORK_ID}|g" /opt/ripple/etc/rippled.cfg
sed -i "s|RIPPLE_VALIDATOR_PUBKEY|${RIPPLE_VALIDATOR_PUBKEY:-$DEFAULT_VALIDATOR_PUBKEY}|g" /opt/ripple/etc/validators.txt

/opt/ripple/bin/rippled --quorum 1 --load --valid "$@"
# this should hopefully give enough time for k8s to kill the pod before running
# next command
sleep 1m

# rippled always returns error code 0, even if it crashes because it's database
# is corrupted or doesn't exist, which means that we have to assume that it
# crashed if it reached this point in the script
echo "clean db, fallback to new ledger"
rm -rf /var/lib/rippled/db/*
/opt/ripple/bin/rippled --quorum 1 --start --valid "$@"