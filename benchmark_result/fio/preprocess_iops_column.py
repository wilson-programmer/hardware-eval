import csv

# Chemin vers le fichier CSV
fichier_csv = "mba/fio_bench_result_xen_4_11_1.csv"

# Indice de la colonne à traiter (commençant à 0)
indice_colonne = 1

# Fonction pour multiplier les valeurs se terminant par "k" par 1000
def multiplier_valeurs_par_1000(valeur):
    if valeur.endswith("k"):
        valeur = float(valeur[:-1]) * 1000
    return valeur

# Lecture du fichier CSV et mise à jour des valeurs de la colonne
with open(fichier_csv, newline='') as csvfile:
    lecteur_csv = csv.reader(csvfile)
    lignes = list(lecteur_csv)
    for ligne in lignes:
        colonne = ligne[indice_colonne]
        ligne[indice_colonne] = multiplier_valeurs_par_1000(colonne)

# Écriture des nouvelles valeurs dans le fichier CSV
with open(fichier_csv, 'w', newline='') as csvfile:
    ecrivain_csv = csv.writer(csvfile)
    ecrivain_csv.writerows(lignes)
