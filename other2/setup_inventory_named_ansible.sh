#!/bin/bash

#Install ansible
# apt update
# apt install -y ansible


# # prepare yaml inventory file that will containt all vms ip address
# number_vm=10
# ip_address=$(awk '{print $1}' mac_ip_address | head -$number_vm)

# #get ip address from 11 to 20
# upper_number_vm=$((number_vm+12))
# ip_address_upper=$(awk '{print $1}' mac_ip_address | head -$upper_number_vm | tail -10)

# #Check wheater hosts file already exists
# if [ -f hosts.yml ]
# then
#     rm hosts.yml
# fi


# Set the base IP address
base_ip="10.132.0."

# Set the starting host number
start_host=1

# Set the number of hosts
num_hosts=10

# Create the inventory file
cat > inventory.yml <<EOF
all:
  hosts:
EOF

# Generate the host entries
for i in $(seq $start_host $((start_host + num_hosts - 1))); do
  host_name="vm$i"
  host_ip="${base_ip}$i"
  cat >> hosts.yml <<EOF
    $host_name:
      ansible_host: $host_ip
EOF
done

echo "Inventory file 'inventory.yml' created successfully."
