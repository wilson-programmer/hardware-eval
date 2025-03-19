#!/bin/bash

patch_stat(){
	#Function to find for a patch, the number of lines added, removed and the number of files updated.
	#@param
		# @patch        : the patch file to compute
	#@Return 
		# modified_files : updated files
		# added_lines    : number of new LOCs(Lines of Codes)
		# deleted_lines  : number of LOCs removed


    local patch=$1
        # Check whether an argument has been supplied
    if [ $# -eq 0 ]; then
        echo "Please provide the path to the patch file."
        exit 1
    fi

    # Check if the patch file exists
    if [ ! -f "$patch" ]; then
        echo "Patch file doesn't exist."
        exit 1
    fi

    # Caractère de séparation
    separator=","


    a=$(grep "insertions(+)" $patch | grep -Eo '[0-9]+')

    #Transform the above result into a line
    line=$(echo "$a" | tr '\n' "$separator" | xargs)

    modified_files=$(echo $line | cut -d "," -f1)
    added_lines=$(echo $line | cut -d "," -f2)
    deleted_lines=$(echo $line | cut -d "," -f3)

	# Check whether there are new lines added
    if [[ -z "$added_lines" ]]
    then
        added_lines=0
    fi

	# Check whether there are  lines removed
    if [[ -z "$deleted_lines" ]]
    then
        deleted_lines=0
    fi
    echo  "$modified_files,$added_lines,$deleted_lines"
}


save_patch_stat(){

	#Function to find for a patch serie, the number of lines added, removed and the number of files updated.
	#@param
		# patch_dir    : the patch serie to compute
		# feature_name : Hardware feature added
	#@Return 
		# modified_files : updated files
		# added_lines    : number of new LOCs(Lines of Code)
		# deleted_lines  : number of LOCs removed
		# feature_name   : Hardware feature added


	local patch_dir=$1
	local feature_name=$2

	modified_files=0
	added_lines=0
	deleted_lines=0

	# Browse the patch directory
	for patch in $patch_dir/*; do
	patch_info=$(patch_stat $patch)

	#Find the number of updated files
	sed -n -e '/^+++/p' $patch >> tmp_file

	#num1=$(echo $patch_info | cut -d "," -f1)
	num2=$(echo $patch_info | cut -d "," -f2)
	num3=$(echo $patch_info | cut -d "," -f3)
	
	added_lines=$(expr $added_lines + $num2)
	deleted_lines=$(expr $deleted_lines + $num3)
	
	done
	modified_files=$(sort tmp_file | uniq | wc -l)

	#Save the patch stats
	echo $feature_name,$modified_files,$added_lines,$deleted_lines >> patch_feature.csv
	exit
}

save_patch_stat $1 $2
