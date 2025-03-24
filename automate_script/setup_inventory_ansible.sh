#!/bin/bash

#Install ansible
apt update
apt install -y ansible


# prepare yaml inventory file that will containt all vms ip address
number_vm=$1
ip_address=$(awk '{print $1}' mac_ip_address | head -$number_vm)

#get ip address from 11 to 20
upper_number_vm=$((number_vm+12))
ip_address_upper=$(awk '{print $1}' mac_ip_address | head -$upper_number_vm | tail -10)

#Check wheater hosts file already exists
if [ -f hosts.yml ]
then
    rm hosts.yml
fi

echo "all:
  hosts:" >> hosts.yml

# for ip in $ip_address
# do
    
#      echo "    $ip:" >> hosts.yml
# done

count=0
for ip in $ip_address
do
    ((count++))
    host_name="vm$count"
    echo "    $host_name:
      ansible_host: $ip " >> hosts.yml
done
