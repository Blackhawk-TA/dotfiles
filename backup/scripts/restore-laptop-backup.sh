#!/bin/sh

echo "Restoring user data from backup"

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

# Configs
sudo rsync -avhP --delete $TARGET_DIR/.gitconfig /home/$USER/.gitconfig
sudo rsync -avhP --delete $TARGET_DIR/.ssh/config /home/$USER/.ssh/config
sudo rsync -avhP --delete $TARGET_DIR/.gnupg /home/$USER/.gnupg
sudo rsync -avhP --delete $TARGET_DIR/.ideavimrc /home/$USER/.ideavimrc
sudo rsync -avhP --delete $TARGET_DIR/.config/unity3d /home/$USER/.config/unity3d
sudo rsync -avhP --delete $TARGET_DIR/.local/share/konsole /home/$USER/.local/share/konsole

# Documents
sudo rsync -avhP --delete $TARGET_DIR/CLionProjects/. /home/$USER/CLionProjects
sudo rsync -avhP --delete $TARGET_DIR/Desktop/. /home/$USER/Desktop
sudo rsync -avhP --delete $TARGET_DIR/Documents/. /home/$USER/Documents
sudo rsync -avhP --delete $TARGET_DIR/git/. /home/$USER/git
sudo rsync -avhP --delete $TARGET_DIR/Music/. /home/$USER/Music
sudo rsync -avhP --delete $TARGET_DIR/Pictures/. /home/$USER/Pictures
sudo rsync -avhP --delete $TARGET_DIR/Videos/. /home/$USER/Videos

# Unmount drive
sudo umount /dev/mapper/$UUID

# Encrypt drive
sudo cryptsetup luksClose /dev/mapper/$UUID

echo "Successfully completed user data restore from backup"

