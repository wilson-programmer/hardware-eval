#!/bin/bash


#vm_client_ip=$1

sudo apt update
sudo apt install -y nfs-kernel-server

nfs_dir=/var/nfs/general

mkdir -p $nfs_dir

#chown nobody:nogroup /var/nfs/general

# get all vms ip address
number_vm=10
ip_address=$(awk '{print $1}' mac_ip_address | head -$number_vm)

#sudo chown nobody:nogroup $nfs_dir

# Exporting the Home Directory

for ip in $ip_address
do
    echo "$nfs_dir    $ip(rw,sync,no_subtree_check)" >> /etc/exports
done

sudo exportfs -a

sudo systemctl restart nfs-kernel-server

apt install -y ufw
ufw allow OpenSSH

ufw enable


for ip in $ip_address:
do
    sudo ufw allow from $ip to any port nfs
done
