#!/bin/sh

echo "Restoring pi data from backup"

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

# Create backup
TARGET_DIR=$MOUNT_DIR/pi-backup
sudo rsync -avhP --delete $TARGET_DIR/uptime-kuma/. /home/$USER/uptime-kuma
sudo rsync -avhP --delete $TARGET_DIR/nas/. /home/$USER/nas
sudo rsync -avhP --delete $TARGET_DIR/pihole-backup.tar.gz /home/$USER/pihole-backup.tar.gz

# Unmount drive
sudo umount /dev/mapper/$UUID

# Encrypt drive
sudo cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed pi data restore from backup"

