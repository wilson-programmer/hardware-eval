#!/bin/bash

# Launch 10 VMs with fio benchmark running in each VM

number_of_run=10

for((i=0;i<$number_of_run;i++))
do
    ansible-playbook -i hosts_vm_creation.yml -u wilson -e "ansible_sudo_pass=1234" playbook_collect_vm_creation_time.yaml 

    echo "Copy ssh key"

    ssh-copy-id -i ~/.ssh/id_rsa.pub wilson@10.132.0.21
    
    echo "Shutting down basevm11..."
    xl shutdown basevm11

    echo "basevm11 off"
    
    sleep 2

    echo "Launching basevm11..."
    xl create vm/basevm11.cfg

    echo "basevm11 launched"

    echo "round $i ok"
done
