FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && \
	apt install php-fpm wget php php-mysql php-redis -y; \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./tools/wordpress-entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh; \
	mkdir -p /var/www/wordpress; \
	mv wordpress/* /var/www/wordpress; \	
	mkdir -p /run/php/; \
	chown -R www-data:www-data /var/www/; \
	chmod -R 777 /var/www/

WORKDIR /var/www/wordpress

# redis
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]
