#!/bin/bash

vm_number=$1

git clone https://github.com/wilson-programmer/bench_result_hadware_evol.git

#cd /home/wilson/bench_result_hadware_evol/fio/
cd /home/wilson/bench_result_hadware_evol/

mkdir -p redis
cd redis
mkdir -p xen_4_11_1

cd /home/wilson/bench_result_hadware_evol/redis/xen_4_11_1

mkdir -p vm$1

cd vm$1

cp -r ../../../../redis_result/ .

git add .

git commit -m "Redis results vm$1 xen 4.11.1 new"

git push


