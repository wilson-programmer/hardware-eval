#!/bin/bash
#Check if a feature is in a release
fichier=/home/wilson/hardware_virtualization/feature_list
rep_release_xen=/home/wilson/hardware_virtualization/xen_releases

#release=$1
#feature=$2

presence_bit=1
absence_bit=0
# if grep -q -rnw $feature $release; then
#     release_basename="$release_basename,$presence_bit"
# fi

for release in $rep_release_xen/*; do

    release_basename=$(basename $release)
    
    while IFS= read -r ligne; do

        if grep -q -rnw $ligne $release; then
            release_basename="$release_basename,$presence_bit"
        
        else
            release_basename="$release_basename,$absence_bit"
        fi
    done < "$fichier"

    echo $release_basename >> /home/wilson/hardware_virtualization/xen_feature_release.csv
done