#!/bin/sh

SCRIPT_DIR="$(pwd)"
mkdir -p $SCRIPT_DIR/tmp

echo "Installing pacman dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git curl neovim python-pynvim texlive-core the_silver_searcher --noconfirm --needed

echo "Installing vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Installing nerd-fonts"
cd tmp
git clone https://github.com/ryanoasis/nerd-fonts.git
/bin/sh $SCRIPT_DIR/tmp/nerd-font/install.sh
cd $SCRIPT_DIR

echo "Downloading nvim config"
cd tmp
git clone https://github.com/Blackhawk-TA/nvim.git
mv nvim /home/$USER/.config/nvim
cd $SCRIPT_DIR

echo "Deleting tmp files"
rm -rf $SCRIPT_DIR/tmp

echo "nvim setup completed"

