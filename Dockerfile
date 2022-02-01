FROM ruby:alpine

# install dependencies
RUN gem install 'imap-backup' && apk add -U --no-cache su-exec

# add cron log
RUN touch /var/log/cron.log

# add entrypoint script
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# add imap backup script
ADD imap-backup.sh /imap-backup.sh
RUN chmod a+x /imap-backup.sh

# setup user and group names and ids
ENV USER imapbackup
ENV UID 17958
ENV GROUP imapbackup
ENV GID 17958

# create user and group
RUN addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} && adduser ${USER} ${GROUP}

# create /data directory, copy config, set owner
RUN mkdir -m770 /data
ADD sample_config.json /data/config.json
RUN chown ${USER}:${GROUP} /data -R

# mount this, if you want to store the config in a volume
VOLUME /data

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["crond","-f", "-L", "/dev/stdout"]
