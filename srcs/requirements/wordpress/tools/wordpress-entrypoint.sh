#!/bin/bash

config_file=/var/www/wp-config.php

# requirements

cp /var/www/wp-config-sample.php $config_file
sed -i "s/database_name_here/$MYSQL_DATABASE/g" $config_file
sed -i "s/username_here/$MYSQL_USER/g" $config_file
sed -i "s/password_here/$MYSQL_PASSWORD/g" $config_file
sed -i "s/database_name_here/$MYSQL_DATABASE/g" $config_file
sed -i "s/localhost/$MYSQL_HOSTNAME/g" $config_file

# redis

wp plugin install redis-cache --allow-root
wp plugin activate redis-cache --allow-root

sed -i '39i\'$'\n' $config_file
sed -i '39i\'$'\n' $config_file
sed -i '40i /** Redis configuration **/' $config_file
sed -i "41i define( 'WP_REDIS_HOST', 'redis' );" $config_file
sed -i "42i define( 'WP_REDIS_PORT', 6379 );" $config_file
sed -i "43i define( 'WP_REDIS_PREFIX', 'inception' );" $config_file
sed -i "43i define( 'WP_REDIS_DATABASE', 0 );" $config_file
sed -i "43i define( 'WP_REDIS_TIMEOUT', 1 );" $config_file
sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );" $config_file

exec "$@"
