#!/bin/bash

#rediriger les résultats dans les dossiers correspondants

rep_source=/home/wilson/netperf_result
count=0
for rep in $rep_source/*; do

    if [[ -f $rep ]] 
    then
    	((count++))
    fi
done

#mkdir round$count

#count=$(expr $count - 2)
cd $rep_source
mkdir $rep_source/round$count

mv $root_dir/netperf_output $root_dir/netperf_output$count

#mv $rep_source/apache_bench_result.csv $rep_source/apache_bench_result$count.csv

