#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p $SCRIPT_DIR/tmp

echo "Installing pacman dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy kitty --noconfirm --needed

echo "Installing fonts"
sudo pacman -Sy ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono --noconfirm --needed

echo "Clone kitty config"
cd tmp || exit 1
git clone git@github.com:Blackhawk-TA/kitty.git
mv kitty /home/$USER/.config/kitty
cd $SCRIPT_DIR || exit 1

echo "Deleting tmp files"
rm -rf $SCRIPT_DIR/tmp

echo "kitty setup completed"
