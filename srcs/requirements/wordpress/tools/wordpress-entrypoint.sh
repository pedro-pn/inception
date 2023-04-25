#!/bin/bash

config_file=/var/www/wp-config.php

cp /var/www/wp-config-sample.php $config_file
sed -i "s/database_name_here/$MYSQL_DATABASE/g" $config_file
sed -i "s/username_here/$MYSQL_USER/g" $config_file
sed -i "s/password_here/$MYSQL_PASSWORD/g" $config_file
sed -i "s/database_name_here/$MYSQL_DATABASE/g" $config_file
sed -i "s/localhost/$MYSQL_HOSTNAME/g" $config_file

exec "$@"
