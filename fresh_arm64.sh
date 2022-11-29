#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

apt update

apt upgrade -y


apt install -y \
unzip zip p7zip-full zsh \
git curl gnupg wget \
vim tmux socat debian-keyring \
debian-archive-keyring apt-transport-https \
ca-certificates lsb-release software-properties-common ffmpeg

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

curl -fsSL https://archive.heckel.io/apt/pubkey.txt | gpg --dearmor -o /etc/apt/keyrings/archive.heckel.io.gpg

sh -c "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/archive.heckel.io.gpg] https://archive.heckel.io/apt debian main' \
    > /etc/apt/sources.list.d/archive.heckel.io.list"

apt update -y

apt install -y caddy btop ntfy \
docker-ce docker-ce-cli containerd.io docker-compose-plugin \
kopia ncdu \
nnn duf vnstat fio \
python3-pip

curl -L "https://github.com/docker/compose/releases/download/v2.13.0/docker-compose-linux-aarch64" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

wget https://github.com/wimpysworld/deb-get/releases/download/0.3.6/deb-get_0.3.6-1_all.deb

dpkg -i deb-get_0.3.6-1_all.deb

rm deb-get_0.3.6-1_all.deb

wget https://github.com/dylanaraps/pfetch/archive/refs/tags/0.6.0.zip

unzip 0.6.0.zip && mv pfetch-0.6.0/pfetch /usr/local/bin/

chmod +x /usr/local/bin/pfetch

rm 0.6.0.zip && rm -rf pfetch-0.6.0/

wget https://github.com/r-darwish/topgrade/releases/download/v9.0.1/topgrade-v9.0.1-aarch64-unknown-linux-gnu.tar.gz

tar -xvf topgrade-v9.0.1-aarch64-unknown-linux-gnu.tar.gz

mv topgrade /usr/local/bin/ && chmod +x /usr/local/bin/topgrade

rm topgrade-v9.0.1-aarch64-unknown-linux-gnu.tar.gz

curl https://rclone.org/install.sh | bash

curl https://getcroc.schollz.com | bash

git clone https://github.com/acmesh-official/acme.sh.git

chmod +x ./acme.sh/acme.sh

cd acme.sh

./acme.sh --install --cert-home /certs

cd ..

rm -rf ./acme.sh

wget https://github.com/barthr/redo/releases/download/v0.5.0/redo_0.5.0_Linux_arm64.tar.gz

tar -xvf redo_0.5.0_Linux_arm64.tar.gz

chmod +x redo

mv redo /usr/local/bin/

rm README.md LICENSE redo_0.5.0_Linux_arm64.tar.gz

rm /etc/ssh/ssh_host_*

ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""

ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""

awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.safe

mv /etc/ssh/moduli.safe /etc/ssh/moduli

sed -i 's/^\#HostKey \/etc\/ssh\/ssh_host_\(rsa\|ed25519\)_key$/HostKey \/etc\/ssh\/ssh_host_\1_key/g' /etc/ssh/sshd_config

echo -e "\n# Restrict key exchange, cipher, and MAC algorithms, as per sshaudit.com\n# hardening guide.\nKexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,gss-curve25519-sha256-,diffie-hellman-group16-sha512,gss-group16-sha512-,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256\nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr\nMACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com\nHostKeyAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256,rsa-sha2-256-cert-v01@openssh.com" > /etc/ssh/sshd_config.d/ssh-audit_hardening.conf

service ssh restart

apt autoremove -y

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
