#!/bin/bash

#rediriger les résultats dans les dossiers correspondants
root_dir=/home/wilson/fio_bench
count=0
for rep in $root_dir/*; do

    if [[ -d $rep ]] 
    then
    	((count++))
    fi
done

#mkdir round$count
mba=_mba

mkdir round$count$mba

mv seq* rand* round$count$mba
