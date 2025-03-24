#!/bin/bash

output_file=fio_bench_result.csv


#This script extract metric from fio benchmark for a specific round

extract_fio_metric(){
    
    local fich=$1
     
    if grep -q "IOPS" $fich;
    then
        iops=$(grep IOPS $fich | grep -oP "IOPS=\K[\d.]+[A-Za-z]*")
        bw=$(grep BW $fich | grep -oP "BW=\K[\d.]+")
        lat_perc95=$(grep "95.00th" $fich)
        # Utilisation des opérations de découpage de chaînes en utilisant les crochets
        lat_perc95=${lat_perc95#*95.00th=[ }   # Supprime tout avant "95.00th=[ "
        lat_perc95=${lat_perc95%]*}   # Supprime tout après le premier crochet fermant

       
        file_name=$(basename $fich)
        #extraire le repertoire parent pour labelliser les fichiers par round
        parent_name=$(dirname $fich)
        parent_name=$(basename $parent_name)
        sep="_"
        file_name=$file_name$sep$parent_name

        echo $file_name,$iops,$bw,$lat_perc95 >> $output_file

    fi
}
#fich=$1
#extract_fio_metric $fich

extract_all_fio_metric(){

    directory=$1
    round=$2

    # Parcours des fichiers et répertoires du répertoire actuel
    for file in "$directory"/*; do
        if [ -d "$file" ]; then

            extract_all_fio_metric $file $round

        elif [ -f $file ]; then
            parent_dir=$(dirname $file)
            parent_dir=$(basename $parent_dir)
            if [ "$parent_dir" == "$round" ]; then
                for subfile in $(dirname $file)/*; do
                extract_fio_metric $subfile
                done
                #echo $round
            
            fi

            #echo $parent_dir
        fi
         
    done
}

extract_fio_metric_all_round(){
    #Extraire les métriques de toutes les VMS et de tous les Rounds

    xen_version_dir=$1
    round=round

    for((i=0;i<10;i++)); do
       

        extract_all_fio_metric $xen_version_dir round$i
    done

}

#input_dir=/home/wilson/hardware_virtualization/hardware_evol_hypervisor/benchmark_result/fio/mba
#input_dir=$1
#round=$2
#extract_all_fio_metric $input_dir $round

xen_version_dir=$1
extract_fio_metric_all_round $xen_version_dir
