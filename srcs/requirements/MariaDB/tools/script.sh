#!/bin/sh

mysql_install_db

/etc/init.d/mysql start
mysql -u root -p -e "CREATE DATABASE wordpressdb;
CREATE USER 'ppaulo-d'@'%' IDENTIFIED BY 'teste';
CREATE USER 'user42'@'%' IDENTIFIED BY '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON wordpressdb.* TO 'user42'@'%' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON wordpressdb.* TO 'ppaulo-d'@'%' IDENTIFIED BY 'teste' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT"
mysql -uppaulo-d -pteste wordpressdb < /db.sql

/etc/init.d/mysql stop