# fresh.sh

script to set up a new ubuntu 20.04 vps

```curl -L https://mni.li/fresh.sh | bash``` # amd64

```curl -L https://mni.li/fresh_arm64.sh | bash``` # arm64

## does the following:

### removes:
* old versions of docker
* snap
* snap folder in /root
* removes un-needed dependencies

### hardens ssh:
as per [guidelines](https://www.sshaudit.com/hardening_guides.html#ubuntu_20_04_lts) on sshaudit.com

### adds these repositories:
* [azlux](https://packages.azlux.fr/)
* [caddy](https://caddyserver.com/docs/install#debian-ubuntu-raspbian)
* [plex](https://support.plex.tv/articles/235974187-enable-repository-updating-for-supported-linux-server-distributions/) `amd64 only`
* [ntfy](https://ntfy.sh/docs/install/#debianubuntu-repository)
* [tailscale](https://tailscale.com/kb/1039/install-ubuntu-2004/)
* [docker](https://docs.docker.com/engine/install/ubuntu/)
* [goaccess](https://goaccess.io/download) `amd64 only`
* [Volian Scar repo](https://deb.volian.org/volian)

### installs:
* caddy
* docker
* docker-compose
* ntfy
* pip3
* bpytop
* borgbackup
* borgmatic
* pfetch
* topgrade
* autorestic
* rclone
* ohmyzsh
* nnn
* goaccess `amd64 only`
* CronitorCLI
* ncdu
* duf
* vnstat
* fio
* nala
