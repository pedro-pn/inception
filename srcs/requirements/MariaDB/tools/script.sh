#!/bin/bash

set -xe

if [ ! -d /var/lib/mysql/wordpressdb ]; then
	# Starts default installation of mysql (mariaDB)
	mysql_install_db

	# Starts mysql service (mariaDB)
	/etc/init.d/mysql start

	# Creates wordpressdb database.
	mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};"

	# Changes root password
	mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';"

	# Deletes anonymous users from default installation.
	mysql -u root -e "DELETE FROM mysql.user WHERE User='';"

	# Disable remote login with root. Only localhost is allowed.
	mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

	# Deletes database "test" from default installation.
	mysql -u root -e "DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"

	# Creates user with a given password.
	mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

	# Creates a second user with a given password.
	mysql -u root -e "CREATE USER '${MYSQL_USER2}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD2}';"

	# Grants some privileges to the second user.
	mysql -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER2}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD2}';"

	# Grants all privileges to the user.
	mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' WITH GRANT OPTION;"

	# Updates privileges.
	mysql -u root -e "FLUSH PRIVILEGES;"

	# Set wordpress dumped database.
	mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /db.sql

	# Stops mysql service (mariaDB), which will be restarted in the container CMD.
	/etc/init.d/mysql stop
fi

# Executes container CMD
exec "$@"
