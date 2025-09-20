#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Install dependencies
sudo zypper ref
sudo zypper in restic

# Create backup directory
mkdir -p /home/$USER/remote-backup

# Copy backup scripts
cp $SCRIPT_DIR/scripts/restic-env.sh /root/.restic-env.sh
cp $SCRIPT_DIR/scripts/restore-backup.sh /home/$USER/remote-backup/restore-backup.sh
cp $SCRIPT_DIR/scripts/server/create-backup.sh /home/$USER/remote-backup/create-backup.sh

# Set permissions of restic env
sudo chmod 700 /root/.restic-env.sh
sudo chown root:root /root/.restic.sh

echo "Copied backup scripts to /home/$USER/remote-backup"
echo "Please edit /root/.restic-env.sh to set your restic credentials"

# Copy systemd service
sudo cp $SCRIPT_DIR/scripts/server/restic-backup.service /etc/systemd/system/restic-backup.service
sudo cp $SCRIPT_DIR/scripts/server/restic-backup.timer /etc/systemd/system/restic-backup.timer

# Enable sustemd service
sudo systemctl daemon-reload
sudo systemctl enable --now restic-backup.timer

echo "Restic backup systemd service enabled and started"
