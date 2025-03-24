#!/bin/bash

#Install differents benchmark app in each vm

number_of_run=10

for((i=0;i<$number_of_run;i++))
do
    ansible-playbook -i hosts.yml -u wilson -e "ansible_sudo_pass=1234" playbook_install_benchapp_vm.yaml 
    echo "VM $i app installed"
done