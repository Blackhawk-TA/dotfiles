#!/bin/bash

set -e

echo "Restoring server data from backup"

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

# Restore from backup
TARGET_DIR=$MOUNT_DIR/server-backup

# User files
rsync -avhP --delete $TARGET_DIR/.docker/. /home/server/.docker
rsync -avhP --delete $TARGET_DIR/valheim-server/. /home/server/valheim-server
rsync -avhP --delete $TARGET_DIR/minecraft-server/. /home/server/minecraft-server
rsync -avhP --delete $TARGET_DIR/itemdrop/. /home/server/itemdrop
rsync -avhP --delete $TARGET_DIR/scripts/. /home/server/scripts
rsync -avhP --delete $TARGET_DIR/media/. /media

# Configs
rsync -avhP --delete $TARGET_DIR/httpd.conf /etc/apache2/httpd.conf
rsync -avhP --delete $TARGET_DIR/nextcloud.conf /etc/apache2/conf.d/nextcloud.conf
rsync -avhP --delete $TARGET_DIR/website.conf /etc/apache2/conf.d/website.conf
rsync -avhP --delete $TARGET_DIR/ddclient.conf /etc/ddclient/ddclient.conf

# Unmount drive
umount /dev/mapper/$UUID

# Encrypt drive
cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed server data restore from backup"
