# docker-bitcoind

Full Bitcoin node that can run locally or in any container orchestration.

See [blockstream.info](https://blockstream.info/) for a good block explorer.




## Start

To startup the node locally,

```
make
```

or

```
make bitcoind
```

Running either of the above will start up `bitcoind` in a container (named "bitcoind") using mainnet
 on the standard ports 8332 (RPC) and 8333 (P2P).

It will create a volume mount in `data/` which will persist between runs.

By default, it will run with `printtoconsole` enabled with the process attached to the terminal.
To stop the server simply press Ctrl-C.


## Testing

To verify your node is running and listening on the standard ports, you can run

```
make curl_test
```

This will attempt to connect with as if it was a remote connection and send an RPC command.


## RPC commands

You can run any RPC command
 (see [RPC API Reference](https://developer.bitcoin.org/reference/rpc/index.html))
 using the simple wrapper function, e.g.,

```
$ bitcoin-cli getbestblockhash
000000000000f075b4d412f510d4a588ba6e9058611bbba2e975f43d0e2d9aef
```

```
bitcoin-cli getblockstats '"0000000000002197bdbfb5e7aa52236926b9e6450bd184cb24c8ca15e2cd3d11"' '["minfeerate","avgfeerate"]'
{
  "avgfeerate": 0,
  "minfeerate": 0
}

```

## Debugging

The above `bitcoin-cli` simply attaches to the running docker container and executes `bitcoin-cli` directly.
If needed, you can attach to the running container as follows,

```
make attach
```

## Cleanup

If you want to purge everything, including the data from mainnet,

```
make clean
```


## Creating a wallet

You can create a wallet with the `createwallet` RPC method,

```
curl --user foo:bar --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": {"wallet_name":"wallet", "descriptors":false}}' \
  -H 'content-type: text/plain;' http://127.0.0.1:8332/
{"result":{"name":"wallet","warning":""},"error":null,"id":"curltest"}
```

And then `listwallets`,

```
bitcoin-cli listwallets
[
    "wallet"
]
```

And `getwalletinfo`,

```
bitcoin-cli getwalletinfo
{
  "walletname": "wallet",
  "walletversion": 169900,
  "format": "bdb",
  "balance": 0.00000000,
  "unconfirmed_balance": 0.00000000,
  "immature_balance": 0.00000000,
  "txcount": 0,
  "keypoololdest": 1669147359,
  "keypoolsize": 1000,
  "hdseedid": "4c2f494852bb582ff26dd4f94e6d3679f7a30912",
  "keypoolsize_hd_internal": 1000,
  "paytxfee": 0.00000000,
  "private_keys_enabled": true,
  "avoid_reuse": false,
  "scanning": false,
  "descriptors": false,
  "external_signer": false
}
```

## Using a wallet

You can get a new address,

```
bitcoin-cli getnewaddress

```

And even dump your private key,

```
bitcoin-cli dumpprivkey "bc1qam7wptd8zcuqqz5awqdygn6qauy9vrxmeff95j"

```

