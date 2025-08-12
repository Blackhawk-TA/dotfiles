#!/bin/bash

# Ensure no other backup process is running
if pgrep -f 'restic backup' >/dev/null; then
	echo 'restic is already running...' 1>&2
	exit 0
fi

# Load restic credentials
source /home/pi/remote-backup/restic-env.sh

export RESTIC_CACHE_DIR="/home/pi/.cache/restic"
mkdir -p "${RESTIC_CACHE_DIR}"

# Run backup
restic unlock
restic backup --tag=automated \
	/home/pi/uptime-kuma \
	/home/pi/nas \
	/home/pi/pihole-backup.tar.gz
restic check --with-cache --read-data-subset=5G
restic forget --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --keep-yearly 3
restic cache --cleanup
