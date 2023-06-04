#!/bin/sh
SCRIPT_DIR="$(pwd)"
DAEMON_CONF_PATH=/etc/pulse/daemon.conf

echo "Creating backup of pulseaudio daemon.conf"
sudo mv $DAEMON_CONF_PATH /etc/pulse/daemon.conf.bkup

echo "Creating new daemon.conf with hi-res audio"
sudo cp $SCRIPT_DIR/configs/daemon.conf /etc/pulse/daemon.conf

AUDIO_SCRIPTS_DIR=/home/$USER/audio-scripts
echo "Copying scripts for switching bitrate to $AUDIO_SCRIPTS_DIR"
mkdir -p $AUDIO_SCRIPTS_DIR
cp $SCRIPT_DIR/scripts/hi-res-audio.sh $AUDIO_SCRIPTS_DIR/hi-res-audio.sh
chmod +x $AUDIO_SCRIPTS_DIR/hi-res-audio.sh
cp $SCRIPT_DIR/scripts/low-res-audio.sh $AUDIO_SCRIPTS_DIR/low-res-audio.sh
chmod +x $AUDIO_SCRIPTS_DIR/low-res-audio.sh

echo "Restarting pulseaudio"
pulseaudio -k

echo "hi-res audio setup completed"
echo "scripts for changing bitrate can be found in $AUDIO_SCRIPTS_DIR"

