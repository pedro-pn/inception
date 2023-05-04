#!/bin/bash

# set (-x) bash cript to debbug mode. (-e) Exit if any command fails.
set -xe

# check if static website exists and create it if false
 if [ ! -d /var/www/static ]; then
	mkdir -p /var/www/static
	mv index.html /var/www/static
	mv nino.jpeg /var/www/static
	chmod 777 /var/www/static/index.html
fi

exec "$@"
