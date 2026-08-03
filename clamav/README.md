# ClamAV

As default, all necessary configs are installed, but live scanning is disabled.
It can be disabled with following commands (the order matters):

```bash
sudo systemctl enable clamav-daemon.service
sudo systemctl start clamav-daemon.service

sudo systemctl enable clamav-clamonacc.service
sudo systemctl start clamav-clamonacc.service

```
