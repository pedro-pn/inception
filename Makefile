DOCKER_SRCS = ./srcs/docker-compose.yml

build:
	docker-compose -f ${DOCKER_SRCS} up --force-recreate --build

all: build

down:
	docker-compose -f ${DOCKER_SRCS} down -v

prune:
	docker system prune -a

re: prune all

.PHONY: all clean fclean build re prune