FROM debian:latest

RUN apt-get update -y && apt-get upgrade -y && \
	apt install php-fpm wget php php-mysql -y

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xvzf latest.tar.gz

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./conf/wp-config.php wordpress/

RUN mkdir -p /var/www/
RUN mv wordpress/* /var/www/
RUN mkdir -p /run/php/

RUN chown -R www-data:www-data /var/www/ \
	&& chmod -R 777 /var/www/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
