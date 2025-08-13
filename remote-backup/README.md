# Restic remote backup

## Requirements

- the environment variables in `restic-env.sh` are different depending on which
  server the backup is performed. Each server has its own restic directory on
  the remote storage to which the backup is stored.
- connecting to the remote storage over ssh has to be set up

## Manual mounting

To manually mount the storage box use following commands:

```bash
mkdir /mnt/storagebox
sshfs u123456@u123456.your-storagebox.de: /mnt/storagebox/
```

Add the ssh key of the server to the storage box allow list:

```bash
cat ~/.ssh/id_ed25519.pub >> /mnt/storagebox/.ssh/authorized_keys
```

Check the file afterwards to ensure the structure is correct and integrates
with the already existing keys.

Unmount storage box:

```bash
fusermount -u /mnt/storagebox
```
