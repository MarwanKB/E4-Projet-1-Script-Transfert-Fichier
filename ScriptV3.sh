#!/bin/bash
#-------------------------------------------------------------------------------
#-- variables
#-------------------------------------------------------------------------------

NomFichier=$1
SOURCE=$2
FichierArchive=$3
DestServeur=$4
CheminFichier=$SOURCE/$NomFichier
Archivage=$5
HOST=$6
LOGIN=$7
motdepasse=$8
RepertoireLog=$9
date=$(date +%H%M%d%m%Y)
#AJOUTER LOG
################################################################################
#-- VERIFICATION DU CHEMIN DU FICHIER                                          #
################################################################################
echo $date
function VerificationChemin() 
{	
	echo
	echo "------------VERIFICATION DU CHEMIN------------"
	echo
	leChemin=$1
	leFichier=$2
	log=$3
	if [ -d $leChemin ]
	then
		if [ -f $leFichier ]
		then
			cd $leChemin
			echo $leFichier est présent dans $leChemin #>> $log
			return 0
		else 
			echo "Le Fichier n'est pas présent" #>> $log
			return 12
		fi
	else
		echo VERIFICATION : $1 "n'est pas un repertoire !" #>> $log
		return 12
	fi
}


################################################################################
#-- VERIFICATION DU FICHIER A TRANSFERER                                       #
################################################################################

# function TransfertFichier()
# {
	# echo
	# echo "------------TRANSFERT DE FICHIER------------"
	# echo 
	# nomfichier=$1
	# destination=$2
	# if [ -f $nomfichier ]
	# then
		# cp $nomfichier $destination
		# echo $nomfichier "à été transferé"
		# return 0
	# else
		# echo "TRANSFERT : " $nomfichier "n'a pas été trouvé"
		# return 12
	# fi
# }


################################################################################
#-- VERIFICATION DU TRANSFERT POUR L'ARCHIVAGE                                 #
################################################################################

function ArchivageFichierRistourne() 
{	
	echo
	echo "------------ARCHIVAGE DE FICHIER------------"
	echo
	nomfichier=$1
	fichier=$(echo $nomfichier | cut -f1 -d'.')
	destArchive=$2
	Archivage=$3
	log=$4
	Cheminfichier=$5
	
	
	echo $destArchive
	echo $nomfichier
	echo $Archivage
	echo $Cheminfichier
	if [ "$Archivage" == "1" ]
	then
		if [ -f $Cheminfichier ]
		then
			ladate=$(date +%d%m%Y)
			cd $SOURCE
			cp $nomfichier $destArchive/${fichier}_$ladate.txt
			echo Archive $nomfichier à été archivé avec succes ! #>> $log
			return 0
		else
			echo "Aucun fichier présent" #>> $log
			return 12
		fi
	else
		echo "ARCHIVE : Aucun Fichier à archiver" #>> $log
		return 12
	fi
}


################################################################################
#-- FTP                                                                        #
################################################################################

function ConnexionFTP
{
	echo
	echo "------------CONNEXION FTP ------------"
	echo
	
	nomfichier=$1
	Cheminlcd=$2
	CheminCd=$3
	HOST=$4
	LOGIN=$5
	PASSWORD=$6	
	echo $nomfichier
	echo $Cheminlcd
	echo $CheminCd
	echo $HOST
	echo $LOGIN
	echo $PASSWORD
	echo debug : $HOST user $LOGIN $PASSWORD
	ftp -i -n $HOST << EOF | tee /home/adminSio/Documents/E4Projet/log.log
user $LOGIN 
put $CheminFichier $NomFichier
EOF
echo "$NomFichier à été transferé vers $DestServeur"

	exit 0 
}


################################################################################
#-- EXECUTION DU SCRIPT                                                        #
################################################################################

if [ "$#" -eq  "9" ]
then
	VerificationChemin "$SOURCE" "$CheminFichier" "$RepertoireLog" 
	ArchivageFichierRistourne "$NomFichier" "$FichierArchive" "$Archivage" "$RepertoireLog" "$CheminFichier"
	ConnexionFTP "$NomFichier" "$SOURCE" "$DestServeur" "$HOST" "$LOGIN" "$motdepasse"
		
else
	echo echec Transfert 
	echo "Nombre d'arguments invalide"
fi

