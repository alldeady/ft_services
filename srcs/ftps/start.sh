#!/bin/sh

adduser -D -h /var/ftp peer
echo "peer:pass" | chpasswd
vsftpd /etc/vsftpd/vsftpd.conf
