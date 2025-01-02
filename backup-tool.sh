#!/bin/bash

# Variables
BACKUP_DIR="/mnt/hdd/backups"
HOSTNAME=$(hostname)
DIR_NAME=$(basename "$PWD")
DATE=$(date +%Y%m%d)
BACKUP_FILE="${BACKUP_DIR}/${HOSTNAME}_${DIR_NAME}_backup_${DATE}.tar.gz"

# Create the tarball with exclusions, including Steam directories
tar --exclude='Downloads' \
    --exclude='.cache' \
    --exclude='.mozilla' \
    --exclude='.local/share/Trash' \
    --exclude='.local/share/Steam' \
    --exclude='.steam' \
    --exclude='.var/app/com.valvesoftware.Steam' \
    -czpf "$BACKUP_FILE" .

# Encrypt the tarball
gpg --symmetric --cipher-algo AES256 "$BACKUP_FILE"

# Optional: Remove the unencrypted tarball after encryption
rm "$BACKUP_FILE"
