#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
	echo "Please run this script as root" 1>&2
	exit 1
fi

# Ensure no other backup process is running
if pgrep -f "restic backup" >/dev/null; then
	echo "Restic is already running..." 1>&2
	exit 1
fi

# Load restic credentials
source /root/.restic-env.sh

export RESTIC_CACHE_DIR="/root/.cache/restic"
mkdir -p "${RESTIC_CACHE_DIR}"

# Run backup
restic unlock
restic backup --tag=automated \
	/home/server/.docker \
	/home/server/valheim-server \
	/home/server/minecraft-server \
	/home/server/itemdrop \
	/home/server/scripts \
	/etc/apache2/httpd.conf \
	/etc/apache2/conf.d/nextcloud.conf \
	/etc/apache2/conf.d/website.conf \
	/etc/ddclient/ddclient.conf \
	/media
restic check --with-cache --read-data-subset=5G
restic forget --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --keep-yearly 3
restic cache --cleanup
restic prune
