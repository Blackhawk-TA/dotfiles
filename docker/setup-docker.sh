#!/bin/sh

echo "Installing docker and docker-compose"
sudo pacman -Sy docker docker-compose --noconfirm --needed

echo "Start docker on startup"
sudo systemctl enable docker
sudo systemctl start docker

echo "Add docker group to user"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
