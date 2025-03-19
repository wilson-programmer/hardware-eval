#!/bin/bash

#Extraire le patch entre deux versions de xen

old_version=$1
new_version=$2
patch_name=patch
patch_name=$(basename $new_version)"."$patch_name

diff -ur $old_version $new_version >> $patch_name

#Remove the lines containing the word Only

sed -i '/Only/d' $patch_name

#Rename xen version in the resulting patch
sed -i -e "s/$new_version/$old_name/g" "$patch_name"

cp  $patch_name /home/wwahalindjeck

