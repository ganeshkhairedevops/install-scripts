#!/bin/bash

<<info
this script is used for taking backup usinf ver and tar.gz
eg.
./backup.sh <soure> <dest>
src /home/ubuntu/scripts
dest /home/ubuntu/backups
info

src=$1 #source
dest=$2 # destination path backup folder

# Create destination if it does not exist
mkdir -p "$dest"

# Timestamp for backup name
timestamp=$(date '+%Y-%m-%d-%H-%M')

# Create backup as tar.gz archive
tar -czf "$dest/backup-$timestamp.tar.gz" -C "$(dirname "$src")" "$(basename "$src")"

# Keep only last 5 backups (delete older ones)
ls -tp "$dest"/backup-*.tar.gz | grep -v '/$' | tail -n +6 | xargs -r rm --

# Optional: Push to AWS S3
# aws s3 sync "$dest" s3://backup_bucket_for_bk

echo "Backup completed at $timestamp"