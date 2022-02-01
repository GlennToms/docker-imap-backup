#!/bin/sh

# take ownership of data directories and files
touch /data/log
chown -R $UID:$GID /data
chmod -R 770 /data

# imap-backup need config in users home folder
mkdir -p /home/${USER}/.imap-backup
cp /data/config.json /home/${USER}/.imap-backup/config.json
chown -R $UID:$GID /home/${USER}/.imap-backup
chmod -R 600 /home/${USER}/.imap-backup/config.json

# add backup script to cron
mv /imap-backup.sh /etc/periodic/15min/imap-backup
chmod +x /etc/periodic/15min/imap-backup

exec crond -f -l 8 & tail -f /data/log
