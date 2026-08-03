#!/bin/bash
# Source: https://wiki.archlinux.org/title/ClamAV

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Installing clamAV"
sudo pacman -Sy clamav --noconfirm --needed

echo "Copying clamd config"
sudo cp $SCRIPT_DIR/configs/clamd.conf /etc/clamav/clamd.conf

echo "Update database"
sudo touch /var/log/clamav/freshclam.log
sudo chmod 600 /var/log/clamav/freshclam.log
sudo chown clamav /var/log/clamav/freshclam.log
sudo freshclam

sudo systemctl enable clamav-freshclam.service
sudo systemctl start clamav-freshclam.service

echo "Setup fangfrisch"
# TODO: Setup fangfrisch

echo "Enable desktop notifications"
sudo cp $SCRIPT_DIR/configs/clamav-sudo /etc/sudoers.d/clamav
sudo cp $SCRIPT_DIR/scripts/virus-event.bash /etc/clamav/virus-event.bash

echo "Patching clamav-clamonacc.service for notification support"
sudo cp $SCRIPT_DIR/scripts/clamav-clamonacc.service /usr/lib/systemd/system/clamav-clamonacc.service
sudo systemctl daemon-reload

echo "Live scanning is disabled as default. For more information, see README.md in dotfiles"
# echo "Enable clamd systemd services"
# sudo systemctl enable clamav-daemon.service
# sudo systemctl start clamav-daemon.service

# sudo systemctl enable clamav-clamonacc.service
# sudo systemctl start clamav-clamonacc.service
