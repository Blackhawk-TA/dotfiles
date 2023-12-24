#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p $SCRIPT_DIR/tmp

echo "Installing pacman dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git curl neovim nodejs npm python-pynvim fd ripgrep --noconfirm --needed

echo "Installing fonts"
sudo pacman -Sy ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

echo "Downloading nvim config"
cd tmp
git clone https://github.com/Blackhawk-TA/nvim.git
mv nvim /home/$USER/.config/nvim
cd $SCRIPT_DIR

echo "Deleting tmp files"
rm -rf $SCRIPT_DIR/tmp

echo "nvim setup completed"

