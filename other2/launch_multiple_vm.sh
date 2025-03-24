#!/bin/bash

#Launch multiple vms at once

#Déterminer le nombre d'images déjà présentes
root_dir=/tmp/VMs_without_mba
nb_img=$(ls -l $root_dir| grep ".img" | wc -l)
nb_img_create=0

#Set the number of VMs, VCPUs, and memory needed
number_vm=$1
vcpus=2
memory=4096
root_dir=/tmp/VMs_without_mba


#Nombre de vm à créer
if [ $number_vm -gt $nb_img ]
then
    nb_img_create=$(($number_vm - $nb_img))
    
fi
except=1
nb_img=$((nb_img+1))

for((i=$nb_img;i<=number_vm;i++))
do
    if (($i != $except))
    then
        cp $root_dir/basevm1.img $root_dir/basevm$i.img
    #else
     #   cp $root_dir/basevm2.img $root_dir/basevm$i.img
     

    fi
    
done


vm_img="basevm"
bridge=br0
vm_config_dir=vm
#mkdir -p $vm_config_dir

if [ -d $vm_config_dir ]
then
    rm -r $vm_config_dir
    mkdir $vm_config_dir
else
    mkdir $vm_config_dir
fi

# get mac address
mac_address=$(awk '{print $2}' mac_ip_address | head -$number_vm)

#get mac address from 11 to 20
upper_number_vm=$((number_vm+10))
mac_address_upper=$(awk '{print $2}' mac_ip_address | head -$upper_number_vm | tail -10)

#Set the configuration files for each vm
count=0
for mac in $mac_address
do
    ((count++))

    echo "
    memory=$memory
    vcpus=$vcpus
    name=\"basevm$count\"
    disk=[ 'file: /tmp/VMs_without_mba/$vm_img$count.img,ioemu:hda,w' ]
    vif=[ 'bridge=$brige,mac=$mac' ]
    bootloader=\"/usr/local/bin/pygrub\"
    " >>$vm_config_dir/basevm$count.cfg

done

#Launch the vms
cd $vm_config_dir
for((i=1;i<=$count;i++))
do
    xl create basevm$i.cfg
    sleep 5
    
done