#!/bin/bash

# set (-x) bash cript to debbug mode. (-e) Exit if any command fails.
set -xe

# Enables connection via TCP/IPV4.
sed -i 's/listen=NO/listen=YES/g' /etc/vsftpd.conf

# Disables connection via ipv6.
sed -i 's/listen_ipv6=YES/listen_ipv6=NO/g' /etc/vsftpd.conf

# Enables users to upload files to the FTP server.
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf

# Restricts users to access only its home directory via FTP.
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' /etc/vsftpd.conf

# Sets a userlist path.
echo "userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

# Allows users of the userlist to login.
echo "userlist_deny=NO" >> /etc/vsftpd.conf

# Enables users to write in its home directory (which is the root for them).
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf

# Adds an user to the FTP server an creates its home directory
adduser --home /home/${FTP_USER} --disabled-password --gecos "${FTP_NAME}" ${FTP_USER}

# Sets user's password
echo "${FTP_USER}:${FTP_PASSWD}" | chpasswd

# Adds user to FTP userlist
echo "${FTP_USER}" >> /etc/vsftpd.userlist

# Executes container CMD
exec "$@"
