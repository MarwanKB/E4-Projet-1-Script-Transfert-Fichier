# SCRIPT TRANSFERT DE DONNEES 
## Présentation 
Le but de ce SCRIPT est de transférer les fichier d'un serveur A vers un serveur B via le protocole FTP en entrant plusieurs paramètres

LE SCRIPT SE TROUVE DANS : /adminSio/Documents/ProjetE4/Script.sh sue la MACHINE P04

## LES PARAMETRES EN ENTREE : 

Plusieurs paramètres sont à préciser : 
  - Le nom du fichier
  - Le chemin source
  - Le Chemin cible
  - L'archivage ou non du fichier (0/1)
  - Repertoire du fichier logs
  - Les informations du serveur cible :
                      - USER
                      - MOT DE PASSE
                      - ADRESSE DU SERVEUR



## LE FONCTIONNEMENT  : 

Après avoir préciser les paramètres, le script vas vérifier l'existence du chemin et la présence du fichier à ce chemin.
Il va d'abord (si l'archivage à été choisit) copier le fichier dans l'archive, puis effectuer la connexion FTP vers le serveur avec les paramètres entrés précédemment et enfin déposer le fichier vers le chemin cible.


## L'UTILISATION DE SOUS FONCTION : 

L'utilisation de sous fonction permet de pouvoir être libre lors du choix des paramètres de l'envoi du fichier. Et choisir que les actions qu'il souhaite effectuer. Comme l'achivage par exemple.
Cela permet de rendre le code universel pour une autre utilisation sur d'autres serveurs.


#LES SOUS FONCTIONS :
La premiere sous fonction : LES VERIFICATIONS
  Elle permet de vérifier l'existence du répertoire et la présence du fichier dans le répertoire.
  
La seconde fonction : L'ARCHIVAGE 
  Elle copie en local le fichier en modifiant le nom (HH MM JJ MM AA + NOM DU FICHIER) vers le fichier ARCHIVE (précisé en paramètre) 
 
La derniere sous fonction : LE TRANSFERT 
  Connexion FTP grace aux paramètres entrés. Puis envoi du fichier vers le serveur distant.
  
