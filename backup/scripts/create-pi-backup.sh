#!/bin/sh

echo "Creating backup of pi..."

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

# Backup PiHole
echo "Creating PiHole backup"
pihole -a -t /home/$USER/pihole-backup.tar.gz

# Create backup of files/directories
TARGET_DIR=$MOUNT_DIR/pi-backup
mkdir -p $TARGET_DIR

sudo rsync -avhP --delete /home/$USER/uptime-kuma $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/nas $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/pihole-backup.tar.gz $TARGET_DIR

# Unmount drive
sudo umount /dev/mapper/$UUID

# Encrypt drive
sudo cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed pi backup"

