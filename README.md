# Ripple Testnet Docker Image

[![](https://images.microbadger.com/badges/version/ulamlabs/ripple-testnet.svg)](https://hub.docker.com/repository/docker/ulamlabs/ripple-testnet)

Docker image which bootstraps a custom Ripple testnet node.

## Usage

Image is available on Docker Hub.

```
docker run ulamlabs/ripple-testnet
```

You can also use provided Docker Compose file. This bootstraps rippled node along with a patched version of @WietseWind [rippled-ws-client-dashboard](https://github.com/WietseWind/rippled-ws-client-dashboard) on port 10080. You can use it to interact with your local node.

## Known quirks and issues

Please wait about ~1 minute for the service to start up. It might take longer for it to produce a valid ledger, as at least first 4 blocks need to be validated While we aim for the data to remain persistent across reboots, it's known that sometimes restoring old state fails, for example after a crash, and ledger gets reset. Due to how Ripple is designed, reserve and fee amounts will be higher for the first 256 ledgers. After that it should settle on 20 XRP reserve and 10 drops per transaction.

## Ports

By default, image exposes services on these ports:

- 5004 - admin RPC,
- 5005 - public RPC,
- 5006 - websocket

## Environment variables

Docker image makes use of these environment variables:

- `RIPPLE_VALIDATOR_PUBKEY` - (optional) validator public key,
- `RIPPLE_VALIDATOR_TOKEN` - (optional) validator token,
- `RIPPLE_NETWORK_ID` - network ID, defaults to `11213711`
