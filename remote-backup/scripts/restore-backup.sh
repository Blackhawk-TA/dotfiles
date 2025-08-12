#!/bin/bash

# Load restic credentials
source $HOME/remote-backup/restic-env.sh

# Restore from latest snapshot
# 'latest' can be replaced with the snapshot ID
restic restore latest --target /
