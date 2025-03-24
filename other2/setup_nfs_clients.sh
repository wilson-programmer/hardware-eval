#!/bin/bash

host_ip=$(cat host_ip)

nfs_dir=/nfs/general
sudo apt update
sudo apt install -y nfs-common

sudo mkdir -p $nfs_dir

# get all vms ip address
number_vm=4
ip_address=$(awk '{print $1}' mac_ip_address | head -$number_vm)

for ip in $ip_address; do

    sudo mount $ip:/var/nfs/general $nfs_dir

done


# mount the remote NFS shares automatically at boot
for ip in $ip_address; do

    echo "$host_ip:/var/nfs/general    $nfs_dir   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab

done

