#!/bin/sh

for dir in */; do
	echo "Updating $dir"
	cd "$dir" || exit 1
	git reset --hard

	if ! (git pull | grep -q 'Already up to date.'); then
		makepkg -si --noconfirm
	fi
	cd ..
done

/bin/sh cleanup.sh

