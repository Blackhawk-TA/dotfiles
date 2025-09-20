#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git base-devel --noconfirm --needed

AUR_DIR=/home/$USER/aur-packages
echo "Creating packages directory in $AUR_DIR"
mkdir $AUR_DIR
cp $SCRIPT_DIR/scripts/update.sh $AUR_DIR/update.sh
chmod +x $AUR_DIR/update.sh
cp $SCRIPT_DIR/scripts/cleanup.sh $AUR_DIR/cleanup.sh
chmod +x $AUR_DIR/cleanup.sh

echo "Cloning aur git repositories"
cd $AUR_DIR
git clone https://aur.archlinux.org/aic94xx-firmware.git
git clone https://aur.archlinux.org/aseprite.git
git clone https://aur.archlinux.org/ast-firmware.git
git clone https://aur.archlinux.org/bruno-bin.git
git clone https://aur.archlinux.org/edmarketconnector.git
git clone https://aur.archlinux.org/golangci-lint.git
git clone https://aur.archlinux.org/imagewriter.git
git clone https://aur.archlinux.org/informant.git
git clone https://aur.archlinux.org/jetbrains-toolbox.git
git clone https://aur.archlinux.org/joplin-bin.git
git clone https://aur.archlinux.org/minecraft-launcher.git
git clone https://aur.archlinux.org/proton-ge-custom-bin.git
git clone https://aur.archlinux.org/protontricks.git
git clone https://aur.archlinux.org/python-vdf.git
git clone https://aur.archlinux.org/tidal-hifi-bin.git
git clone https://aur.archlinux.org/umlet.git
git clone https://aur.archlinux.org/unixbench.git
git clone https://aur.archlinux.org/wd719x-firmware.git
git clone https://aur.archlinux.org/woeusb-ng.git
git clone https://aur.archlinux.org/xone-dkms.git
git clone https://aur.archlinux.org/xone-dongle-firmware.git
git clone https://aur.archlinux.org/zsh-vi-mode.git

echo "Installing aur packages"
for dir in */; do
	echo "Installing $dir"
	cd $dir
	git reset --hard
	makepkg -si --noconfirm
	cd ..
done

echo "Completed aur package installations"

