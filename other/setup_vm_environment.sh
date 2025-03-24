#!/bin/bash

apt update
apt install -y net-tools

a=$(ifconfig | grep enp | cut -d : -f 1)

export nic=$a
export mac='ac:91:a1:23:50:59'


brctl addbr xenbr0
brctl addif xenbr0 $nic
dhclient xenbr0
ifconfig $nic 0.0.0.0


