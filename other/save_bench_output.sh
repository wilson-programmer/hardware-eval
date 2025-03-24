#!/bin/bash

vm_number=$1
#rm -r bench_result_hadware_evol
git clone https://github.com/wilson-programmer/bench_result_hadware_evol.git


cd /home/wilson/bench_result_hadware_evol/fio/xen_4_12_2
#cd /home/wilson/bench_result_hadware_evol/redis/xen_4_11_4
=======
#cd /home/wilson/bench_result_hadware_evol/fio/xen_4_12_4
cd /home/wilson/bench_result_hadware_evol/redis/xen_4_12_4


mkdir vm$vm_number

cd vm$vm_number

#cp -r ../../../../fio_result/ .
cp -r ../../../../redis_result/ .

git add .


git commit -m "Fio results vm$vm_number xen 4.12.2"
=======
git commit -m "Fio results vm$vm_number xen 4.12.4"

#git commit -m "redis results vm$vm_number xen 4.11.4"

git push



# vim push_to_github.sh

# chmod +x push_to_github.sh
