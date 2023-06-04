#!/bin/sh
sudo sed -i 's/default-sample-rate = 384000/default-sample-rate = 192000/g' /etc/pulse/daemon.conf
sudo sed -i 's/default-sample-format = s32le/default-sample-format = s16le/g' /etc/pulse/daemon.conf
pulseaudio -k

