#!/bin/bash

set -e

echo "Creating backup of server..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
	echo "Please run this script as root" 1>&2
	exit 1
fi

# Mount backup disk
UUID="9874a7e1-8ce5-4c46-9365-ba38eba0b927"
DISK_PATH="$(findfs UUID=$UUID)"
if [ -z "$DISK_PATH" ]; then
	echo "Backup disk not connected"
	exit 1
fi

# Decrypt drive
cryptsetup luksOpen $DISK_PATH $UUID

# Create mounting point and mount disk
MOUNT_DIR=/home/server/backup/disk
mkdir -p $MOUNT_DIR
mount -o compress=zstd /dev/mapper/$UUID $MOUNT_DIR

# Create nextcloud database dump file in /home/server/scripts directory
/bin/bash /home/server/scripts/nextcloud-db-backup.sh

# Create backup
TARGET_DIR=$MOUNT_DIR/server-backup
mkdir -p $TARGET_DIR

# User files
rsync -avhP --delete /home/server/.docker $TARGET_DIR
rsync -avhP --delete /home/server/valheim-server $TARGET_DIR
rsync -avhP --delete /home/server/minecraft-server $TARGET_DIR
rsync -avhP --delete /home/server/itemdrop $TARGET_DIR
rsync -avhP --delete /home/server/scripts $TARGET_DIR
rsync -avhP --delete /media $TARGET_DIR

# Configs
rsync -avhP --delete /etc/apache2/httpd.conf $TARGET_DIR
rsync -avhP --delete /etc/apache2/conf.d/nextcloud.conf $TARGET_DIR
rsync -avhP --delete /etc/apache2/conf.d/website.conf $TARGET_DIR
rsync -avhP --delete /etc/ddclient/ddclient.conf $TARGET_DIR

# Unmount drive
umount /dev/mapper/$UUID

# Encrypt drive
cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed server backup"
