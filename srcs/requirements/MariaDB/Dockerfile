FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
	apt install mariadb-server mariadb-client -y

COPY ./conf/db.sql .

COPY ./conf/my.cnf /etc/mysql/conf

COPY ./tools/script.sh /usr/local/bin

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

RUN chmod 777 /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT ["script.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
