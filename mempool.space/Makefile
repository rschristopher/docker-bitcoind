.PHONY: mempool clean attach
UID := $(shell id -u)
GID := $(shell id -g)
export


mempool:
	mkdir -p data
	mkdir -p mysql
	docker-compose up

clean:
	rm -rf data
	rm -rf mysql
	docker system prune -af

attach:
	docker exec -it mempool.db bash

