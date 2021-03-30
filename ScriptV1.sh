#!/bin/sh
#-------------------------------------------------------------------------------
#-- variables
#-------------------------------------------------------------------------------

SOURCE=$1
CheminFichier=$2
NomFichier=${cheminFichier:32}
DESTINATION="/stor/rpyfr1/stage/serveurB/in/"

################################################################################
#-- VERIFICATION DU CHEMIN DU FICHIER                                          #
################################################################################

function VerificationChemin() 
{	
	echo
	echo "------------VERIFICATION DU CHEMIN------------"
	echo
	leChemin=$1
	leFichier=$2
	if [ -d $leChemin ]
	then
		if [ -f $leFichier ]
		then
			cd $leChemin
			echo $leFichier est présent dans $leChemin
			return 0
		else 
			echo "Le Fichier n'est pas présent"
			return 12
		fi
	else
		echo VERIFICATION : $1 "n'est pas un repertoire !"
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
	destination=$2
	echo $nomfichier
	if [ "$nomfichier" == "/stor/rpyfr1/stage/serveurA/out/Ristourne_stage.txt" ]
	then
		if [ -f $nomfichier ]
		then
			ladate=$(date +%d%m%Y)
			cd $SOURCE
			cp $nomfichier /stor/rpyfr1/stage/serveurA/archive/Ristourne_stage_$ladate.txt
			echo Archive $nomfichier à été archivé avec succes !
			return 0
		else
			return 12
		fi
	else
		echo "ARCHIVE : Aucun Fichier à archiver"
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
	HOST="u203rwt021-pis1"
	LOGIN="pgsa"
	PASSWORD="pgsa"
	ftp -i -n $HOST << EOF | tee log_ftp.log
user $LOGIN $PASSWORD 
cd stage/in
dir
lcd /stor/rpyfr1/stage/serveurA/out
put $nomfichier
quit
EOF
	exit 0 
}


################################################################################
#-- EXECUTION DU SCRIPT                                                        #
################################################################################

if [ "$#" -eq  "2" ]
then
	if [ -d $DESTINATION ]
	then
		VerificationChemin "$SOURCE" "$CheminFichier" 
		ArchivageFichierRistourne "$CheminFichier" "$DESTINATION"
		ConnexionFTP "$NomFichier"
		
	else
		echo echec Transfert 

	fi
else
	echo "Nombre d'arguments invalide"
fi



