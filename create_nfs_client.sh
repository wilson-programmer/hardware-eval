#!/bin/bash

host_ip=$1

nfs_dir=/srv/storage/killerdroid@storage2.rennes.grid5000.fr/datasets/dynamic_approach/hardware_evol/Benchmark_Result/nfs
sudo apt update
sudo apt install -y nfs-common

sudo mkdir -p /nfs

sudo mount $host_ip:$nfs_dir /nfs

echo "$host_ip:$nfs_dir    /nfs   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab
