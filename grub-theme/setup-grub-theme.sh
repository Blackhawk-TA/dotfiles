#!/bin/sh

SCRIPT_PATH="$(pwd)"

echo "Installing dependencies"
sudo pacman -Sy archlinux-keyring --noconfirm --needed
sudo pacman -Syu --noconfirm --needed
sudo pacman -Sy git --noconfirm --needed

echo "Cloning themes from GitHub"
mkdir -p $SCRIPT_PATH/tmp
cd $SCRIPT_PATH/tmp
git clone https://github.com/Se7endAY/grub2-theme-vimix.git
cd $SCRIPT_PATH

THEMES_DIR=/boot/grub/themes
echo "Copying theme to $THEMES_DIR"
if [ ! -d "$THEMES_DIR" ]; then
	echo "The directory $THEMES_DIR does not exist, exiting..."
	rm -rf $SCRIPT_PATH/tmp #Cleanup tmp
	exit 1
fi
sudo cp -r $SCRIPT_PATH/tmp/grub2-theme-vimix/Vimix $THEMES_DIR/vimix

echo "Deleting temporary files"
rm -rf $SCRIPT_PATH/tmp

echo "Creating backup of grub config"
GRUB_CONF=/etc/default/grub
if [ ! -f "$GRUB_CONF" ]; then
	echo "The grun config does not exist at $GRUB_CONF, exiting..."
	exit 1
fi
sudo cp $GRUB_CONF /etc/default/grub.bkup

echo "Setting theme in grub config"
echo "GRUB_THEME="/boot/grub/themes/vimix/theme.txt"" | sudo tee -a $GRUB_CONF

echo "Updating grub"
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "grup theme setup completed"
