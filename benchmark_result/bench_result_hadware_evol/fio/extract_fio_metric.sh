#!/bin/bash

output_file=fio_bench_result.csv

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

    local directory="$1"

    # Parcours des fichiers et répertoires du répertoire actuel
    for file in "$directory"/*; do
        if [ -d "$file" ]; then
            # Si c'est un répertoire, on rappelle la fonction traverse_directory récursivement
            extract_all_fio_metric "$file"
        elif [ -f "$file" ]; then
            
            # Si c'est un fichier, vous pouvez effectuer ici l'action désirée
            extract_fio_metric $file
        fi
    done
}

#input_dir=/home/wilson/hardware_virtualization/hardware_evol_hypervisor/benchmark_result/fio/mba
#Exemple de chemin à fournir: ./extract_fio_metric.sh xen_4_10_4_mba/vm0/fio_result/
input_dir=$1
extract_all_fio_metric $input_dir
