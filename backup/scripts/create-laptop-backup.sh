#!/bin/sh

echo "Creating backup of user data..."

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
TARGET_DIR=$MOUNT_DIR/arch-laptop-backup
mkdir -p $TARGET_DIR

# Configs
sudo rsync -avhP --delete /home/$USER/.gitconfig $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/.ssh/config $TARGET_DIR/.ssh
sudo rsync -avhP --delete /home/$USER/.gnupg $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/.config/unity3d $TARGET_DIR/.config
sudo rsync -avhP --delete /home/$USER/.local/share/konsole $TARGET_DIR./local/share

# Documents
sudo rsync -avhP --delete /home/$USER/Desktop $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/Documents $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/git $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/Music $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/Pictures $TARGET_DIR
sudo rsync -avhP --delete /home/$USER/Videos $TARGET_DIR

# Unmount drive
sudo umount /dev/mapper/$UUID

# Encrypt drive
sudo cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed user data backup"

