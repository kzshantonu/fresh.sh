# fresh.sh

script to set up a new ubuntu 20.04 vps

```curl -L https://zer0.url.lol/fresh.sh | bash```
```curl -L https://zer0.url.lol/fresh_arm64.sh | bash``` # arm64

## does the following:

### removes:
* old versions of docker
* snap
* snap folder in /root
* removes un-needed dependencies

### hardens ssh:
as per guidelines on https://www.sshaudit.com/hardening_guides.html#ubuntu_20_04_lts

### adds these repositories:
* [azlux](https://packages.azlux.fr/)
* [caddy](https://caddyserver.com/docs/install#debian-ubuntu-raspbian)
* [plex](https://support.plex.tv/articles/235974187-enable-repository-updating-for-supported-linux-server-distributions/)
* [ntfy](https://ntfy.sh/docs/install/#debianubuntu-repository)
* [tailscale](https://tailscale.com/kb/1039/install-ubuntu-2004/)
* [docker](https://docs.docker.com/engine/install/ubuntu/)
* [speedtest](https://www.speedtest.net/apps/cli)

### installs:
* caddy
* docker
* docker-compose
* ntfy
* pip3
* bpytop
* borgmatic
* acme.sh
* pfetch
* topgrade
* autorestic
* rclone
* ohmyzsh
* nnn
* speedtest
