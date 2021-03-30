#!/bin/sh
#-------------------------------------------------------------------------------
#-- variables
#-------------------------------------------------------------------------------

SOURCE=$1
LIBELLE=$2
DESTINATION="/stor/rpyfr1/stage/serveurB"

################################################################################
#-- Execution du script                                                        #
################################################################################

#for fichier in $(find $1 -iname "*_date+%Y%m%d.csv")
#	do
#	if [ -d $1 ]
#	then
#		if [ -d $DESTINATION ]
#		then
#			cd $1
#			mv fichier $DESTINATION
#			echo "Le transfert à été effectué."
#			exit 0
#		else
#			echo "Fichier introuvable"
#			exit 12
#		fi
#	else
#		echo "Aucune cible de destination trouvé !"
#		exit 12
#	fi
#done 

if [ "$#" -eq  "2" ]
then
	if [ -d $1 ]
	then
		if [ -d $DESTINATION ]
		then
			if [ -f $1/AVOIR_STAGE_$2 ]
			then
				cd $1
				mv AVOIR_STAGE_$2.csv $DESTINATION 
				echo "Le transfert à été effectué."
				exit 0
			else
				echo "Fichier introuvable"
				exit 12
			fi
			if [ -f $1/NOTE_DEBIT_STAGE_$2 ]
			then
				cd $1
				mv NOTE_DEBIT_STAGE_$2.csv $DESTINATION 
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
else
	echo "Nombre d'arguments invalide."
	exit 12
fi
