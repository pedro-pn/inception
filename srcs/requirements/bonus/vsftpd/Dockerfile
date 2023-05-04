FROM debian:buster

RUN apt-get update && apt-get upgrade -y; \
	apt-get install vsftpd -y

COPY ./tools/vsftpd-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/vsftpd-entrypoint.sh; \
	mkdir -p /var/run/vsftpd/empty

EXPOSE 20-21

ENTRYPOINT [ "vsftpd-entrypoint.sh" ]

CMD ["vsftpd"]
