.PHONY: all bitcoind Fulcrum lnd stop logs clean attach attach-lnd curl_test getblockchaininfo getmininginfo
UID := $(shell id -u)
GID := $(shell id -g)
export


all: bitcoind Fulcrum lnd


bitcoind:
	mkdir -p data
	docker-compose up -d bitcoind

Fulcrum:
	mkdir -p fulcrum-data
	docker-compose up -d Fulcrum

lnd:
	mkdir -p lnd
	docker-compose up -d lnd

stop:
	docker-compose down --remove-orphans

logs:
	docker-compose logs -f

logs-bitcoind:
	docker-compose logs bitcoind -f

logs-Fulcrum:
	docker-compose logs Fulcrum -f

logs-lnd:
	docker-compose logs lnd -f

clean:
	rm -rf data
	rm -rf fulcrum-data
	rm -rf lnd
	docker system prune -af

attach:
	docker exec -it bitcoind bash

attach-lnd:
	docker exec -it lnd bash

curl_test:
	curl -u foo:bar --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockchaininfo","params":[]}' http://127.0.0.1:8332/

getblockchaininfo:
	docker exec --user bitcoin bitcoind bitcoin-cli getblockchaininfo

getmininginfo:
	docker exec --user bitcoin bitcoind bitcoin-cli getmininginfo
