.PHONY: mempool stop logs clean attach
UID := $(shell id -u)
GID := $(shell id -g)
export


mempool:
	mkdir -p cache
	chmod 777 cache
	docker-compose up -d

stop:
	docker-compose down --remove-orphans

logs:
	docker-compose logs -f

clean:
	rm -rf data
	rm -rf mysql
	#docker system prune -af

attach:
	docker exec -it mempool.api bash

