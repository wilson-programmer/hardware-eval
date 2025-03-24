#!/bin/bash

#Vm snapshot time
time xl save -c dom_id snapshot_name basevm2.cfg
time xl save -c 8 checkpointfile basevm2.cfg

xen with mba
real	0m4.999s
user	0m0.099s
sys	0m4.925s

#Vm removal time

real	0m0.700s
user	0m0.143s
sys	0m0.617s


Xen without mba

#Vm snapshot time
real	0m5.050s
user	0m0.070s
sys	0m4.995s



#vm removal time
real	0m0.694s
user	0m0.137s
sys	0m0.608s



