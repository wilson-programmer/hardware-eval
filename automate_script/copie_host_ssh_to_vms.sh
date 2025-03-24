#!/bin/bash

#Copie ssh key of host to all vms

number_vm=$1
ip_address=$(awk '{print $1}' mac_ip_address | head -$number_vm)


for ip in $ip_address
do
    
    ssh-copy-id -i ~/.ssh/id_rsa.pub wilson@$ip
done
