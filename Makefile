.PHONY: bitcoind clean attach curl_test getblockchaininfo getmininginfo
UID := $(shell id -u)
GID := $(shell id -g)
export


bitcoind:
	mkdir -p data
	docker-compose up

clean:
	rm -rf data
	docker system prune -af

attach:
	docker exec -it bitcoind bash

curl_test:
	curl -u foo:bar --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockchaininfo","params":[]}' http://127.0.0.1:8332/

getblockchaininfo:
	docker exec --user bitcoin bitcoind bitcoin-cli getblockchaininfo

getmininginfo:
	docker exec --user bitcoin bitcoind bitcoin-cli getmininginfo
