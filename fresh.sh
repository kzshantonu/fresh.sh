#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

## update and upgrade system

apt update -y
apt upgrade -y
apt dist-upgrade -y
apt full-upgrade -y

## install prerequisites

apt install -y \
unzip zip p7zip-full zsh \
git curl gnupg wget aria2 \
vim neovim tmux neofetch mosh socat \
debian-keyring debian-archive-keyring \
apt-transport-https ca-certificates lsb-release

## set up azlux, docker, ntfy, tailscale, caddy and plex repositories

echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] https://packages.azlux.fr/debian/ bullseye main" | tee /etc/apt/sources.list.d/azlux.list
wget -O /usr/share/keyrings/azlux-archive-keyring.gpg https://azlux.fr/repo.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | tee /etc/apt/trusted.gpg.d/caddy-stable.asc
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add -
curl -sSL https://archive.heckel.io/apt/pubkey.txt | apt-key add -
echo "deb [arch=amd64] https://archive.heckel.io/apt debian main" > /etc/apt/sources.list.d/archive.heckel.io.list
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | tee /etc/apt/sources.list.d/tailscale.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

## update and remove snap

apt update -y
apt purge -y snapd

## cleanup

rm -rf /root/snap
apt autoremove -y
apt remove -y docker docker-engine docker.io containerd runc

## install caddy and docker

apt install -y caddy docker-ce docker-ce-cli containerd.io

## install docker-compose

curl -L "https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

## install ntfy, pip, borgmatic

apt install -y ntfy \
python3-pip
pip3 install bpytop
pip3 install borgmatic

## install acme.sh with certificates dir set to /certs

mkdir /certs
git clone https://github.com/acmesh-official/acme.sh.git
cd acme.sh
./acme.sh --install --cert-home /certs
cd ~
rm -rf ./acme.sh

## install pfetch

wget https://github.com/dylanaraps/pfetch/archive/refs/tags/0.6.0.zip
unzip 0.6.0.zip && mv pfetch-0.6.0/pfetch /usr/local/bin/
chmod +x /usr/local/bin/pfetch
rm 0.6.0.zip && rm -rf pfetch-0.6.0/

## install topgrade

wget https://github.com/r-darwish/topgrade/releases/download/v8.2.0/topgrade-v8.2.0-x86_64-unknown-linux-gnu.tar.gz
tar -xvf topgrade-v8.2.0-x86_64-unknown-linux-gnu.tar.gz
mv topgrade /usr/local/bin/ && chmod +x /usr/local/bin/topgrade
rm topgrade-v8.2.0-x86_64-unknown-linux-gnu.tar.gz

## install autorestic (also installs restic)

wget -qO - https://raw.githubusercontent.com/CupCakeArmy/autorestic/master/install.sh | bash

## install rclone

curl https://rclone.org/install.sh | bash

## install ohmyzsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
