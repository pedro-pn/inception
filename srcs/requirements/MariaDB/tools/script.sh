#!/bin/bash
set -xe


if [ ! -d /var/lib/mysql/wordpressdb ]; then
	mysql_install_db
	/etc/init.d/mysql start

	mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};
	UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	CREATE USER '${MYSQL_USER2}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD2}';
	GRANT SELECT, INSERT, UPDATE, DELETE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER2}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD2}';
	GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
	EXIT"
	mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /db.sql
fi

exec "$@"
