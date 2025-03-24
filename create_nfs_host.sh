#!/bin/bash


vm_client_ip=$1

sudo apt update
sudo apt install -y nfs-kernel-server

nfs_dir=/srv/storage/killerdroid@storage2.rennes.grid5000.fr/datasets/dynamic_approach/hardware_evol/Benchmark_Result/nfs

#sudo chown nobody:nogroup $nfs_dir

echo "$nfs_dir    $vm_client_ip(rw,sync,no_subtree_check)" >> /etc/exports

sudo systemctl restart nfs-kernel-server

apt install -y ufw
ufw allow OpenSSH

ufw enable

sudo ufw allow from $vm_client_ip to any port nfs
