#!/bin/sh

echo "Restoring server data from backup"

# Mount backup disk
UUID="9874a7e1-8ce5-4c46-9365-ba38eba0b927"
DISK_PATH="$(sudo findfs UUID=$UUID)"
if [ -z "$DISK_PATH" ]; then
	echo "Backup disk not connected"
	exit 1
fi

# Decrypt drive
sudo cryptsetup luksOpen $DISK_PATH $UUID

# Create mounting point and mount disk
MOUNT_DIR=/home/$USER/backup/disk
mkdir -p $MOUNT_DIR
sudo mount -o compress=zstd /dev/mapper/$UUID $MOUNT_DIR

# Restore from backup
TARGET_DIR=$MOUNT_DIR/server-backup

# User files
sudo rsync -avhP --delete $TARGET_DIR/.docker/. /home/$USER/.docker
sudo rsync -avhP --delete $TARGET_DIR/valheim-server/. /home/$USER/valheim-server
sudo rsync -avhP --delete $TARGET_DIR/minecraft-server/. /home/$USER/minecraft-server
sudo rsync -avhP --delete $TARGET_DIR/itemdrop/. /home/$USER/itemdrop
sudo rsync -avhP --delete $TARGET_DIR/media/. /media

# Apache2 configs
sudo rsync -avhP --delete $TARGET_DIR/httpd.conf /etc/apache2/httpd.conf
sudo rsync -avhP --delete $TARGET_DIR/nextcloud.conf /etc/apache2/conf.d/nextcloud.conf
sudo rsync -avhP --delete $TARGET_DIR/website.conf /etc/apache2/conf.d/website.conf

# Unmount drive
sudo umount /dev/mapper/$UUID

# Encrypt drive
sudo cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed server data restore from backup"
