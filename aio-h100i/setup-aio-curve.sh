#!/bin/sh

echo "Setting up AIO fan and pump curve"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy liquidctl --noconfirm --needed

echo "Copying systemd script"
sudo cp $SCRIPT_DIR/scripts/liquidcfg.service /etc/systemd/system/liquidcfg.service

echo "Enabling and starting script"
sudo systemctl enable liquidcfg.service
sudo systemctl start liquidcfg.service

echo "Completed AIO setup"

