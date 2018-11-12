#!/bin/sh
# restore the backup: infomr the snapshots ID
# Set the repository that hold the data
# by defualt the restoration folder is /tmp/restic-restore
echo "restoring"

restoringFolder="/tmp/restic-restore"

restic restore  $1 -t  $restoringFolder
