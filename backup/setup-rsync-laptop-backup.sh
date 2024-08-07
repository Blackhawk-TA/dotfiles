#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Install dependencies
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Sy rsync cryptsetup --noconfirm --needed

# Create backup directory
mkdir -p /home/$USER/backup

# Copy backup scripts
cp $SCRIPT_DIR/scripts/create-laptop-backup.sh /home/$USER/backup/create-laptop-backup.sh
cp $SCRIPT_DIR/scripts/restore-laptop-backup.sh /home/$USER/backup/restore-laptop-backup.sh

