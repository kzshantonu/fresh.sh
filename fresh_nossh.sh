#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apt update -y

apt upgrade -y


apt install -y \
unzip zip p7zip-full zsh \
git curl gnupg wget aria2 \
vim neovim tmux neofetch mosh socat \
debian-keyring debian-archive-keyring \
apt-transport-https ca-certificates lsb-release software-properties-common

apt remove -y docker docker-engine docker.io containerd runc

mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list

curl -s https://kopia.io/signing-key | gpg --dearmor -o /usr/share/keyrings/kopia-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/kopia-keyring.gpg] http://packages.kopia.io/apt/ stable main" | tee /etc/apt/sources.list.d/kopia.list

echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] https://packages.azlux.fr/debian/ bullseye main" | tee /etc/apt/sources.list.d/azlux.list

wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg

apt update -y

apt install -y caddy \
docker-ce docker-ce-cli containerd.io docker-compose-plugin \
kopia ncdu \
nnn duf vnstat fio \
python3-pip

curl -L "https://github.com/docker/compose/releases/download/v2.12.0/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

wget https://github.com/wimpysworld/deb-get/releases/download/0.3.6/deb-get_0.3.6-1_all.deb

dpkg -i deb-get_0.3.6-1_all.deb

rm deb-get_0.3.6-1_all.deb

pip3 install bpytop

wget https://github.com/dylanaraps/pfetch/archive/refs/tags/0.6.0.zip

unzip 0.6.0.zip && mv pfetch-0.6.0/pfetch /usr/local/bin/

chmod +x /usr/local/bin/pfetch

rm 0.6.0.zip && rm -rf pfetch-0.6.0/

wget https://github.com/r-darwish/topgrade/releases/download/v9.0.1/topgrade-v9.0.1-x86_64-unknown-linux-gnu.tar.gz

tar -xvf topgrade-v9.0.1-x86_64-unknown-linux-gnu.tar.gz

mv topgrade /usr/local/bin/ && chmod +x /usr/local/bin/topgrade

rm topgrade-v9.0.1-x86_64-unknown-linux-gnu.tar.gz

curl https://rclone.org/install.sh | bash

curl https://getcroc.schollz.com | bash

apt autoremove -y

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
