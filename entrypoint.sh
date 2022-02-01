#!/bin/sh

# take ownership of data directories and files
chown -R $UID:$GID /data
chmod -R 770 /data

# imap-backup need config in users home folder
mkdir -p /home/${USER}/.imap-backup
cp /data/config.json /home/${USER}/.imap-backup/config.json
chown -R $UID:$GID /home/${USER}/.imap-backup
chmod -R 600 /home/${USER}/.imap-backup/config.json

# add backup script to crontab
echo "0 * * * * exec su-exec $UID:$GID /imap-backup.sh" | crontab -

# run backup script once at startup
exec su-exec $UID:$GID /imap-backup.sh
