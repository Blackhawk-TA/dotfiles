#!/bin/sh

for dir in */; do
	echo "Cleaning up $dir"
	cd "$dir" || exit 1
	PKG_DIR=$(pwd)
	if [ -f "$PKG_DIR/*.pkg.tar.zst" ]; then
		rm "$PKG_DIR/*.pkg.tar.zst"
	fi
	if [ -f "$PKG_DIR/*.tar.gz" ]; then
		rm "$PKG_DIR/*.tar.gz"
	fi
	if [ -f "$PKG_DIR/*.deb" ]; then
		rm "$PKG_DIR/*.deb"
	fi
	cd ..
done

