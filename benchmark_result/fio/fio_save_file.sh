#!/bin/bash

#rediriger les résultats dans les dossiers correspondants

count=0
for rep in ./*; do

    if [[ -d $rep ]] 
    then
    	((count++))
    fi
done

mkdir round$count

mv seq* rand* round$count


