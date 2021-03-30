#!/bin/sh
#-------------------------------------------------------------------------------
#-- variables
#-------------------------------------------------------------------------------

SOURCE="/stor/rpyfr1/stage/serveurA"
SOURCEFICHIER="/stor/rpyfr1/stage/serveurA/AVOIR_STAGE_07012021.csv"
NOMFICHIER="AVOIR_STAGE_07012021.csv"
DESTINATION="/stor/rpyfr1/stage/serveurB"

################################################################################
#-- Execution du script                                                        #
################################################################################
echo "Le fichier à transférer est $NOMFICHIER de $SOURCE vers $NOMDOSSIER"


if [ -d $SOURCE ]
then
	if [ -d $DESTINATION ]
	then
		if [ -f $SOURCEFICHIER ]
		then
			cd $SOURCE
			mv $NOMFICHIER $DESTINATION 
			echo "Le transfert à été effectué."
			exit 0
		else
			echo "Fichier introuvable"
			exit 12
		fi
	else 
		echo "Aucun repertoire de destination trouvé !"
		exit 12
	fi
else 
	echo "Aucun repertoire source trouvé !"
	exit 12
fi
