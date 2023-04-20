FROM debian:latest

RUN apt-get update && apt-get upgrade -y && \
	apt install mariadb-server mariadb-client -y

COPY ./conf/db.sql .

COPY ./conf/my.cnf /etc/mysql/conf

COPY ./tools/script.sh .

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

RUN bash script.sh

RUN chmod 777 script.sh

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]
