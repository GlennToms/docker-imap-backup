#!/bin/sh

echo "[$(date)] Starting imap backup…" | tee -a /data/log
exec su-exec $UID:GID /usr/local/bundle/bin/imap-backup 2>&1 | tee -a /data/log
echo "[$(date)] Backup finished!" | tee -a /data/log
echo "----------------------------------------------------------------------------" | tee -a /data/log
