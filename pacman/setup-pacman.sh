#!/bin/sh

echo "Installing reflector for mirrorlist updates"
sudo pacman -Sy reflector --noconfirm --needed

echo "Updating pacman config"
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf
sudo sed -i -e '/^#\[multilib\]/s/^#//' -e '/^\[multilib\]/{n;s/^#//}' /etc/pacman.conf

echo "Updating mirrors"
sudo reflector --country 'Germany' --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "Completed pacman setup"
