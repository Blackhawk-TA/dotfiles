#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy tmux git --noconfirm --needed

echo "Install tmux package manager"
mkdir -p $HOME/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm


echo "Setup tmux config"
CONFIG_PATH=$SCRIPT_DIR/configs/tmux.conf
if [ ! -f "$CONFIG_PATH" ]; then
	echo "tmux config not found in configs directory, exiting..."
	exit 1
fi
cp $CONFIG_PATH $HOME/.config/tmux/tmux.conf

