#!/bin/sh
sudo sed -i 's/default-sample-rate = \(384000\|192000\)/default-sample-rate = 44100/g' /etc/pulse/daemon.conf
sudo sed -i 's/default-sample-format = s32le/default-sample-format = s16le/g' /etc/pulse/daemon.conf
pulseaudio -k

