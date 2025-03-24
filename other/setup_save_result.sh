#!/bin/bash

for((i=1;i<=2;i++))
do
    echo """---
- hosts: all
  become: yes
  tasks:
    - name: Create client directory on NFS share
      file:
        path: /var/general/nfs/{{ inventory_hostname }}
        state: directory
        mode: '0755'

    - name: Fetch the script output
      fetch:
        src: /home/wilson/redis_result/redis_bench_result$i.csv
        dest: /var/general/nfs/{{ inventory_hostname }}/redis_bench_result$i.csv
        flat: yes
""" >> playbook$i.yaml
done