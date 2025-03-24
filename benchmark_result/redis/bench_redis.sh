#!/bin/bash

/etc/init.d/redis-server start

redis-benchmark -n 1000000 -c 100 --csv -d 128 -P 8 >> redis_bench_result.csv

#rediriger les résultats dans les dossiers correspondants

count=0
for rep in ./*; do

    if [[ -f $rep ]] 
    then
    	((count++))
    fi
done

count=$(expr $count - 2)

#mkdir round$count

mv redis_bench_result.csv redis_bench_result$count.csv

sleep 5
/etc/init.d/redis-server stop
