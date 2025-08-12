#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Install dependencies
sudo zypper ref
sudo zypper in restic

# Create backup directory
mkdir -p /home/$USER/remote-backup

# Copy backup scripts
cp $SCRIPT_DIR/scripts/restic-env.sh /home/$USER/remote-backup/restic-env.sh
cp $SCRIPT_DIR/scripts/restore-backup.sh /home/$USER/remote-backup/restore-backup.sh
cp $SCRIPT_DIR/scripts/server/create-backup.sh /home/$USER/remote-backup/create-backup.sh

echo "Copied backup scripts to /home/$USER/remote-backup"
echo "Please edit /home/$USER/remote-backup/restic-env.sh to set your restic credentials"

# Copy systemd service
cp $SCRIPT_DIR/scripts/server/restic-backup.service /etc/systemd/system/restic-backup.service
cp $SCRIPT_DIR/scripts/server/restic-backup.timer /etc/systemd/system/restic-backup.timer

# Enable sustemd service
sudo systemctl daemon-reload
sudo systemctl enable --now restic-backup.timer

echo "Restic backup systemd service enabled and started"
