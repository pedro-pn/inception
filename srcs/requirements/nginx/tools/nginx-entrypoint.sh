#!/bin/bash

set -xe

 if [ ! -d /var/www/static ]; then
	mkdir -p /var/www/static
	mv index.html /var/www/static
	mv nino.jpeg /var/www/static
	chmod 777 /var/www/static/index.html
fi

exec "$@"
