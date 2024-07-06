#!/bin/sh

sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed

echo "Installing gaming related packages"
sudo pacman -Sy teamspeak3 steam steam-native-runtime --noconfirm --needed

echo "Installing development related packages"
sudo pacman -Sy tiled vi go --noconfirm --needed

echo "Installing utility packages"
sudo pacman -Sy firefox tree signal-desktop nextcloud-client vlc --noconfirm --needed

