.PHONY: mempool clean attach
UID := $(shell id -u)
GID := $(shell id -g)
export


mempool:
	mkdir -p data
	chmod 777 data
	mkdir -p mysql
	docker-compose up -d

stop:
	docker-compose down --remove-orphans

logs:
	docker-compose logs -f

clean:
	rm -rf data
	rm -rf mysql
	docker system prune -af

attach:
	docker exec -it mempool.api bash

