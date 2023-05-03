DOCKER_SRCS = ./srcs/docker-compose.yml

build:
	docker-compose -f ${DOCKER_SRCS} up --force-recreate --build

all: build

reset:
	sudo rm -rf /home/pedro/Desktop/data/*
	mkdir /home/pedro/Desktop/data/www
	mkdir /home/pedro/Desktop/data/mysql
	mkdir /home/pedro/Desktop/data/redis
	mkdir /home/pedro/Desktop/data/monitoring

down:
	docker-compose -f ${DOCKER_SRCS} down -v

prune:
	docker system prune -a

re: prune all

.PHONY: all clean fclean build re prune