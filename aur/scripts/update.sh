#!/bin/sh

for dir in */; do
	echo "Updating $dir"
	cd $dir
	git reset --hard

	if !(git pull | grep -q 'Already up to date.'); then
		makepkg -si --noconfirm
	fi
	cd ..
done

