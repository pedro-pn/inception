DOCKER_SRCS = ./srcs/docker-compose.yml

include ./srcs/.env
export

build: dirs
	docker-compose -f ${DOCKER_SRCS} up --force-recreate --build

all: host build

host:
	cat /etc/hosts || sudo touch /etc/hosts
	cat /etc/hosts | grep ppaulo-d.42.fr || sudo sh -c 'echo "127.0.0.1 ppaulo-d.42.fr" >> /etc/hosts'

dirs:
	sudo mkdir -p ${INCEPTION_DIR}/inception/www
	sudo mkdir -p ${INCEPTION_DIR}/inception/mysql
	sudo mkdir -p ${INCEPTION_DIR}/inception/redis
	sudo mkdir -p ${INCEPTION_DIR}/inception/monitoring


clean: down
	@ sudo rm -rf ${INCEPTION_DIR}/inception/*

reset: clean dirs

down:
	docker-compose -f ${DOCKER_SRCS} down -v

prune:
	docker system prune -a
	docker volume rm $(docker volume ls -q)

re: down reset all

.PHONY: all clean fclean build re prune