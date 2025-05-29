#!/bin/sh

for dir in */; do
	echo "Cleaning up $dir"
	cd "$dir" || exit 1
	if [ `ls -1 ./*.pkg.tar.zst 2>/dev/null | wc -l` -gt 0 ]; then
		rm ./*.pkg.tar.zst
	fi
	if [ `ls -1 ./*.tar.gz 2>/dev/null | wc -l` -gt 0 ]; then
		rm ./*.tar.gz
	fi
	if [ `ls -1 ./*.deb 2>/dev/null | wc -l` -gt 0 ]; then
		rm ./*.deb
	fi
	cd ..
done

