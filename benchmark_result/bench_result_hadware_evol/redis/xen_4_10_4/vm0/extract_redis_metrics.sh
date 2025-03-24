#!/bin/bash

# Vérifier si les trois arguments ont été fournis
if [ "$#" -ne 3 ]; then
    echo "Utilisation: $0 <fichier1.csv> <fichier2.csv> <fichier_sortie.csv>"
    exit 1
fi

# Stocker les noms des fichiers dans des variables
file1="$1"
file2="$2"
output_file="$3"

# Vérifier si les fichiers d'entrée existent
if [ ! -f "$file1" ] || [ ! -f "$file2" ]; then
    echo "L'un des fichiers d'entrée n'existe pas."
    exit 1
fi

# Additionner les valeurs des deux dataframes
awk '
BEGIN {
    FS=","  # Séparateur de champs par défaut est la virgule
}
{
    # Parcourir les champs de la ligne courante
    for (i=1; i<=NF; i++) {
        sum[i] += $i  # Ajouter la valeur du champ courant au total
    }
}
END {
    # Afficher les totaux dans le fichier de sortie
    for (i=1; i<=NF; i++) {
        printf("%s,", sum[i])
    }
    print ""
}
' "$file1" "$file2" > "$output_file"