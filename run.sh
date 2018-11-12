#!/bin/sh
#change the restic password as you want
# backup at midnight every saturday : 0 0 * * sat
# backup every midnight : 0 0 * * *
echo "Removing old container names 'backup-test' if exists"
docker rm -f -v backup-test || true

echo "Start backup-test container. Backup of ~/Git/AIT/test-data to repository backblaze B2"
docker run --privileged --name backup-test \
-e "RESTIC_PASSWORD=test" \
-e "RESTIC_TAG=test" \
-e "BACKUP_CRON=0 0 * * *" \
-e "RESTIC_FORGET_ARGS=--keep-last 10" \
-v ~/Git/AIT/test-data:/data \
-v /tmp/test-repo/:/mnt/restic \
-t restic-backup-inbackblaze \
-d
