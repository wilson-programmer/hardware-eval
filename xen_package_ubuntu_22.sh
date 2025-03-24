#!/bin/bash

#Xen library for ubuntu 22.04 and debain 10

apt-get -qq install build-essential
apt-get -qq install bcc bin86 gawk bridge-utils iproute2 libcurl4 libcurl4-openssl-dev bzip2 kmod transfig tgif pkg-config
apt-get -qq install texinfo texlive-latex-base texlive-latex-recommended texlive-fonts-extra texlive-fonts-recommended libpci-dev mercurial
apt-get -qq install make gcc libc6-dev zlib1g-dev python-all python-all-dev python3-twisted libncurses5-dev patch libvncserver-dev libsdl1.2-dev libjpeg-dev
apt-get -qq install python3-dev libglib2.0-dev
apt-get -qq install libnl-3-dev libnl-cli-3-dev libnl-genl-3-dev libnl-route-3-dev libnl-idiag-3-dev libnl-xfrm-3-dev
apt-get -qq install iasl libbz2-dev e2fslibs-dev git-core uuid-dev ocaml ocaml-findlib ocamlbuild libx11-dev bison flex xz-utils libyajl-dev
apt-get -qq install gettext libpixman-1-dev libaio-dev markdown pandoc iasl cmake figlet
 
apt-get -qq install libssh2-1-dev libssh-dev libsnappy-dev
apt-get -qq install libc6-dev-i386
apt-get -qq install lzma lzma-dev liblzma-dev
apt-get -qq install libsystemd-dev
 
apt-get -qq install libzstd-dev
apt-get -qq install ninja-build

apt-get -qq install libssl-dev

apt update
apt install python3-venv python3-pip python3-setuptools
python3 -m pip install tomli

