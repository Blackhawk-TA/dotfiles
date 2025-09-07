#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CONFIG_PATH=$HOME/.config/pipewire/pipewire.conf.d

# Install pipewire
sudo pacman -Sy pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber

# Setup config
mkdir -p $CONFIG_PATH
cp $SCRIPT_DIR/configs/10-samplerate.conf $CONFIG_PATH/10-samplerate.conf

# Disable pulseaudio
sudo systemctl --global disable pulseaudio.socket
systemctl --user disable --now pulseaudio.socket pulseaudio.service

# Enable pipewire
systemctl --user enable --now pipewire pipewire-pulse wireplumber
