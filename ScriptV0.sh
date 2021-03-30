#!/bin/sh
#-------------------------------------------------------------------------------
#-- variables
#-------------------------------------------------------------------------------

SOURCE=$1
LIBELLE=$2
DESTINATION="/stor/rpyfr1/stage/serveurB"
ARCHIVE="/stor/rpyfr1/stage/archive"

################################################################################
#-- VERIFICATION DU CHEMIN DU FICHIER                                          #
################################################################################

function fonctionVerifChemin() 
{	
	leChemin=$1
	if [ -d $leChemin ]
	then
		cd $leChemin
		return 0
	else 
		echo "Aucun repertoire source trouvé !"
	fi
}


################################################################################
#-- VERIFICATION DU TRANSFERT POUR L'ARCHIVAGE                                 #
################################################################################

function VerifTransfert() 
{	
	libelle=$2
	destination=$1
	if [ -f $destination/NOTE_DEBIT_STAGE_$LIBELLE.csv ]
	then
		cd $destination
		mv NOTE_DEBIT_STAGE_$libelle.csv $ARCHIVE
		return 0
	else
		echo "le transfert n'a pas été correctement effectué Impossible d'archiver le fichier"
		return 12
	fi
	
	if [ -f $destination/AVOIR_STAGE_$LIBELLE.csv ]
	then
		cd $destination
		mv AVOIR_STAGE_$LIBELLE.csv $ARCHIVE
		return 0
	else
		echo "le transfert n'a pas été correctement effectué Impossible d'archiver le fichier"
		return 12
	fi
}

################################################################################
#-- VERIFICATION DU FICHIER A TRANSFERER                                       #
################################################################################

function fonctionVerifFichier()
{
	leChemin=$1
	libelle=$LIBELLE
	destination=$2
	if [ -f $leChemin/AVOIR_STAGE_$LIBELLE.csv ]
	then
		cd $1
		mv AVOIR_STAGE_$LIBELLE.csv $destination 
		echo "Le transfert à été effectué."
		return 0
	else
		echo "Fichier introuvable"
		return 12
	fi
	
	if [ -f $leChemin/NOTE_DEBIT_STAGE_$LIBELLE.csv ]
	then
		cd $1
		mv NOTE_DEBIT_STAGE_$LIBELLE.csv $destination 
		echo "Le transfert à été effectué."
		return 0
	else
		echo "Fichier introuvable"
		return 12
	fi
}


################################################################################
#-- EXECUTION DU SCRIPT                                                        #
################################################################################

if [ "$#" -eq  "2" ]
then
	fonctionVerifChemin "$SOURCE" 
	if [ -d $DESTINATION ]
	then
		fonctionVerifFichier "$SOURCE" "$DESTINATION"
		VerifTransfert "$DESTINATION" "$LIBELLE"
		
	else
		echo "Chemin de destination introuvable"
	fi
else
	echo "Nombre d'arguments invalide"
fi

