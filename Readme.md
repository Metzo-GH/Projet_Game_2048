#Game 2048 in Pharo
Ce projet est une implémentation du jeu 2048 en Pharo, un langage de programmation orienté objet basé sur Smalltalk.

#Description
Le jeu 2048 est un jeu de puzzle numérique dans lequel le joueur combine des tuiles numérotées pour atteindre la tuile 2048.

#Comment jouer
##Déplacements
Utilisez les touches fléchées pour déplacer les tuiles dans les directions souhaitées.
##Fusion des Tuiles
Les tuiles ayant la même valeur fusionneront en une seule tuile avec une valeur doublée.

#Installation
###Installer les dépendances
Lancer le script suivant pour installer Bloc :
```smalltalk
[ Metacello new
	baseline: 'Bloc';
	repository: 'github://pharo-graphics/Bloc:dev-1.0/src';
	onConflictUseIncoming;
	ignoreImage;
	load ]
		on: MCMergeOrLoadWarning
		do: [ :warning | warning load ]
```
###Installer le jeux
####Il faudra cloner ce repertoire dans pharo avec les informations suivantes :
Owner Name: Metzo-GH
Project Name: Projet_Game_2048

###Lancer le Jeux
Il faut executer le script suivant dans le playground :
```smalltalk
GAME2048 openGame
```

#Contributeurs
##Mariem MSEIKA
##Mohamed MBENGUE
