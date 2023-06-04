#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git --noconfirm --needed

AUR_DIR=/home/$USER/aur-packages
echo "Creating packages directory in $AUR_DIR"
mkdir $AUR_DIR
cp $SCRIPT_DIR/scripts/update.sh $AUR_DIR/update.sh
chmod +x $AUR_DIR/update.sh

echo "Cloning aur git repositories"
echo "TODO: Implement"
