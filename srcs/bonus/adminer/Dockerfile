FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y; \
	apt-get install php php-fpm wget php-mysql -y; \
	mkdir -p /var/www/adminer && \
	wget "http://www.adminer.org/latest.php" -O /var/www/adminer.php; \
	mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

EXPOSE 8080

CMD ["/usr/sbin/php-fpm7.3", "-F"]
