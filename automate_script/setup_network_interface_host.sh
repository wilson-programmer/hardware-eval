#!/bin/bash

# Update /etc/network/interfaces of the host to set the bridge interface to br0
bridge=$(cat /etc/network/interfaces | grep en | head -1 | awk '{print $2}')

echo "" > /etc/network/interfaces

echo "
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

auto $bridge
iface $bridge inet manual
  #auto ib0
  #iface ib0 inet manual
     #pre-up ifup $bridge

auto br0
iface br0 inet dhcp
  bridge_ports $bridge
  bridge_hw $bridge
  bridge_stp off
  bridge_maxwait 0
  bridge_fd 0
" >> /etc/network/interfaces

# restart network services
systemctl restart networking
