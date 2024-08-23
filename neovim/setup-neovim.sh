#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mkdir -p $SCRIPT_DIR/tmp

echo "Installing pacman dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git curl neovim wl-clipboard xclip nodejs npm python-pynvim fd ripgrep go unzip lazygit luarocks --noconfirm --needed

echo "Installing other dependencies"
sudo npm install -g swagger-ui-watcher

echo "Installing fonts"
sudo pacman -Sy ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono --noconfirm --needed

echo "Clone nvim config"
cd tmp || exit 1
git clone git@github.com:Blackhawk-TA/nvim.git
mv nvim /home/$USER/.config/nvim
cd $SCRIPT_DIR || exit 1

echo "Deleting tmp files"
rm -rf $SCRIPT_DIR/tmp

echo "nvim setup completed"
