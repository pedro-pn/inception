#!/bin/bash

set -xe

sed -i 's/listen=NO/listen=YES/g' /etc/vsftpd.conf
sed -i 's/listen_ipv6=YES/listen_ipv6=NO/g' /etc/vsftpd.conf
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' /etc/vsftpd.conf
echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf
echo "userlist_deny=NO" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
adduser --home /home/${FTP_USER} --disabled-password --gecos "${FTP_NAME}" ${FTP_USER}
echo "${FTP_USER}:${FTP_PASSWD}" | chpasswd
echo "${FTP_USER}" >> /etc/vsftpd.userlist

exec "$@"
