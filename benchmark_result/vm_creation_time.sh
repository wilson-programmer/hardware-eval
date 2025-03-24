#!/bin/bash

# Capture VM list with timestamps before creation
vm_list_before=$(xl list -v)

# Launch your VM creation command here (replace with your actual command)
xl create -c basevm2.cfg

# Wait for VM to be created (replace with your VM identification method)
# This step might require additional commands depending on your setup

# Capture VM list with timestamps after creation
vm_list_after=$(xl list -v)



# Extract creation time from before list (assuming newest VM is created last)
before_time=$(echo "$vm_list_before" | grep '<time>' | tail -n 1 | awk '{print $2}')

# Extract creation time from after list
after_time=$(echo "$vm_list_after" | grep '<time>' | tail -n 1 | awk '{print $2}')

# Calculate creation time difference
creation_time=$(($(date +%s) - before_time))
echo "VM creation time: $creation_time seconds" >> creation_vm_time.txt
