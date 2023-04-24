FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install nginx -y

RUN apt-get install openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -new -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -keyout /etc/nginx/ssl/ppaulo-d.key -out /etc/nginx/ssl/ppaulo-d.crt -subj "/C=BR/ST=SP/L=SP/O=42 School/OU=ppaulo-d/CN=ppaulo-d.42.fr/"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
