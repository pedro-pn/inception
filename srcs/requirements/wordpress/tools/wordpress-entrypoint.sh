#!/bin/bash

set -xe
config_file=/var/www/wordpress/wp-config.php

# requirements
if [ ! -f /var/www/wordpress/wp-config.php ]; then
	cp /var/www/wordpress/wp-config-sample.php $config_file
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" $config_file
	sed -i "s/username_here/$MYSQL_USER/g" $config_file
	sed -i "s/password_here/$MYSQL_PASSWORD/g" $config_file
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" $config_file
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" $config_file
fi

# redis
if ! cat $config_file | grep -q "Redis configuration" ; then
	wp plugin install redis-cache --allow-root
	wp plugin activate redis-cache --allow-root
	sed -i '39i\'$'\n' $config_file
	sed -i '39i\'$'\n' $config_file
	sed -i '40i /** Redis configuration **/' $config_file
	sed -i "41i define( 'WP_REDIS_HOST', '${REDIS_HOST}' );" $config_file
	sed -i "42i define( 'WP_REDIS_PORT', '${REDIS_PORT}' );" $config_file
	sed -i "43i define( 'WP_REDIS_PREFIX', 'inception' );" $config_file
	sed -i "43i define( 'WP_REDIS_DATABASE', 1 );" $config_file
	sed -i "43i define( 'WP_REDIS_TIMEOUT', 1 );" $config_file
	sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );" $config_file
	sed -i "68i define('WP_CACHE', true);" $config_file
	sed -i "69i define('WP_CACHE_KEY_SALT', '${REDIS_CACHE_KEY_SALT}');" $config_file
	wp redis enable --allow-root
fi

exec "$@"
