FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y; \
	apt-get install nginx -y; \
	apt-get install openssl -y; \
	mkdir -p /etc/nginx/ssl; \
	openssl req -new -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
	-keyout /etc/nginx/ssl/ppaulo-d.key -out /etc/nginx/ssl/ppaulo-d.crt -subj \ 
	"/C=BR/ST=SP/L=SP/O=42 School/OU=ppaulo-d/CN=ppaulo-d.42.fr/"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./tools/index.html .
COPY ./tools/nino.jpeg .
COPY ./tools/nginx-entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

EXPOSE 443

ENTRYPOINT [ "nginx-entrypoint.sh" ]

CMD ["nginx", "-g", "daemon off;"]
