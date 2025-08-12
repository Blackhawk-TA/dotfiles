#!/bin/bash

# Ensure no other backup process is running
if pgrep -f 'restic backup' >/dev/null; then
	echo 'restic is already running...' 1>&2
	exit 0
fi

# Load restic credentials
source $HOME/remote-backup/restic-env.sh

export RESTIC_CACHE_DIR="$HOME/.cache/restic"
mkdir -p "${RESTIC_CACHE_DIR}"

# Run backup
restic unlock
restic backup \
	$HOME/.docker \
	$HOME/valheim-server \
	$HOME/minecraft-server \
	/media
restic check --with-cache --read-data-subset=5G
restic forget --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --keep-yearly 3
