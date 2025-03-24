#!/bin/bash

# Launch 10 VMs with apache benchmark running in each VM

number_of_run=5

for((i=0;i<$number_of_run;i++))
do
    ansible-playbook -i hosts.yml -u wilson -e "ansible_sudo_pass=1234" playbook_apache.yaml 
    echo "round $i ok"
done
