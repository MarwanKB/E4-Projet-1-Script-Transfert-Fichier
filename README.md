# SCRIPT TRANSFERT DE DONNEES 
## Présentation 
Le but de ce SCRIPT est de transférer les fichier d'un serveur A vers un serveur B via le protocole FTP en entrant plusieurs paramètres

## LES PARAMETRES EN ENTREE : 

Plusieurs paramètres sont à préciser : 
  - Le nom du fichier
  - Le chemin source
  - Le Chemin cible
  - L'archivage ou non du fichier (0/1)
  - Le chemin des logs
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

