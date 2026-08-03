# empty-directory-cleaner
Un logiciel pour supprimer tout les sous-dossiers vides en bash

Ce script à été penser pour les machines linux

Il utilise les commandes suivantes ls, wc, rmdir

Usage,

```bash
./main.sh <BASE_DIR> <-a | --all>
``` 

BASE_DIR vaut par défaut . , c'est le chemin relatif vers le dossier dont on souhaite supprimer les dossiers vides

-a est une option pour prendre en compte les fichiers cacher


Attention, rmdir ne peut pas supprimer un dossier si il contient des fichiers, donc si un fichier caché n'est pas détecté par le script alors il ne pourra pas supprimer le dossier
