#!/bin/sh

SCRIPT_DIR="$(pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git --noconfirm --needed

echo "Create packages directory for user"
mkdir /home/$USER/packages


