# Restic remote backup

## Requirements

- the environment variables in `restic-env.sh` are different depending on which
  server the backup is performed. Each server has its own restic directory on
  the remote storage to which the backup is stored.
- connecting to the remote storage over ssh has to be set up
