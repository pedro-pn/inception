FROM debian:buster

RUN apt-get update && apt-get upgrade -y; \
	apt-get install redis-server php-redis -y

RUN echo "maxmemory 128mb" >> /etc/redis/redis.conf && \
	echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "--protected-mode no"]
