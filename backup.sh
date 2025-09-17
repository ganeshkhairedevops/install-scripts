#!/bin/bash

<<info
This script is used for taking backup
Usage: using path
./backup.sh <source> <destination>
Example:
src=/home/ubuntu/scripts
dest=/home/ubuntu/backups
info

src=/root/scripts/   # Source folder
dest=/root/devops/backup # Destination backup folder

# Create destination if it does not exist
mkdir -p "$dest"

# Timestamp for backup name
timestamp=$(date '+%Y-%m-%d-%H-%M')

# Create backup as zip file
zip -r "$dest/backup-$timestamp.zip" "$src" > /dev/null

# Keep only last 5 backups (delete older ones)
ls -tp "$dest"/backup-*.zip | grep -v '/$' | tail -n +6 | xargs -r rm --

# Optional: Push to AWS S3
# aws s3 sync "$dest" s3://backup_bucket_for_bk

echo "Backup completed at $timestamp"

