#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

add-apt-repository -y ppa:costamagnagianfranco/borgbackup

apt update

apt install -y python3-pip

pip3 install --upgrade borgmatic
