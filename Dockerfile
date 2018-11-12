FROM alpine as certs
RUN apk add --no-cache ca-certificates


FROM busybox:glibc

COPY --from=certs /etc/ssl/certs /etc/ssl/certs

# Get restic executable
ENV RESTIC_VERSION=0.9.3
ADD https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_amd64.bz2 /
RUN bzip2 -d restic_${RESTIC_VERSION}_linux_amd64.bz2 && mv restic_${RESTIC_VERSION}_linux_amd64 /bin/restic && chmod +x /bin/restic

RUN mkdir -p /mnt/restic /var/spool/cron/crontabs /var/log

#Backblaze account
ENV B2_ACCOUNT_ID=""
ENV B2_ACCOUNT_KEY=""
ENV RESTIC_REPOSITORY=/mnt/restic
ENV RESTIC_PASSWORD=""
ENV RESTIC_TAG=""
ENV NFS_TARGET=""
# By default backup every 6 hours
ENV BACKUP_CRON="0 */6 * * *"
ENV RESTIC_FORGET_ARGS=""
ENV RESTIC_JOB_ARGS=""

# /data is the dir where you have to put the data to be backed up
VOLUME /data

COPY b2_passwd.txt /etc/restic/
COPY b2_env.sh /etc/restic/
COPY backup.sh /bin/backup
COPY restore.sh /bin/restore

COPY entry.sh /entry.sh

RUN touch /var/log/cron.log

WORKDIR "/"

ENTRYPOINT ["/entry.sh"]

