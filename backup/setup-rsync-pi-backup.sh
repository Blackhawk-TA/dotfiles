#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Install dependencies
sudo apt-get update
sudo apt-get install -y rsync cryptsetup

# Create backup directory
mkdir -p /home/$USER/backup

# Copy backup scripts
cp $SCRIPT_DIR/scripts/create-pi-backup.sh /home/$USER/backup/create-pi-backup.sh
cp $SCRIPT_DIR/scripts/restore-pi-backup.sh /home/$USER/backup/restore-pi-backup.sh

