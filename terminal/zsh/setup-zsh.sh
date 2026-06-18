#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy curl git --noconfirm --needed

echo "Generate locale en_US.UTF-8"
sudo locale-gen en_US.UTF-8

echo "Installing zsh"
sudo pacman -Sy zsh zsh-syntax-highlighting zsh-autosuggestions --noconfirm --needed

echo "Setting zsh as default shell"
ZSH_PATH=/usr/bin/zsh

if [ ! -f "$ZSH_PATH" ]; then
	echo "zsh binary not found, exiting..."
	exit 1
fi
chsh -s /usr/bin/zsh

echo "Installing omz"
OMZ_DIR=/home/$USER/.oh-my-zsh
if [ -d "$OMZ_DIR" ]; then
	echo ".oh-my-zsh directory already exists, skipping omz installation."
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Installing zsh plugins on system"
AUR_DIR=$HOME/aur-packages
mkdir -p $AUR_DIR
git clone https://aur.archlinux.org/zsh-vi-mode.git $AUR_DIR/zsh-vi-mode
cd $AUR_DIR/zsh-vi-mode || echo "Failed to install zsh plugins using aur"
makepkg -si --noconfirm
cd $SCRIPT_DIR || exit 1

echo "Applying .zshrc from configs directory"
ZSH_RC_PATH=$SCRIPT_DIR/configs/dot-zshrc
if [ ! -f "$ZSH_RC_PATH" ]; then
	echo ".zshrc config not found in configs directory, exiting..."
	exit 1
fi
cp $ZSH_RC_PATH $HOME/.zshrc

echo "zsh setup completed, reload terminal to see effects"

