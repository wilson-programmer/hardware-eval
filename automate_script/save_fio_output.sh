#!/bin/bash

#rediriger les résultats dans les dossiers correspondants
root_dir=/home/wilson/fio_result
count=0
for rep in $root_dir/*; do

    if [[ -d $rep ]] 
    then
    	((count++))
    fi
done

cd $root_dir
mkdir $root_dir/round$count

mv $root_dir/seq* $root_dir/rand* round$count
