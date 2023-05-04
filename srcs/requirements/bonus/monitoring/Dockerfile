FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y; \
	apt-get install clang make libreadline-dev curl git -y; \
	git clone https://github.com/pedro-pn/monitoring; \
	make -C monitoring; \
	mv ./monitoring/monitoring /usr/local/bin; \
	mkdir moni

COPY ./conf/monitoring.db ./moni

WORKDIR /moni

CMD [ "monitoring" ]
