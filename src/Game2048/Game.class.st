Class {
	#name : #Game,
	#superclass : #Object,
	#category : #Game2048
}

{ #category : #'as yet unclassified' }
Game class >> menuBar [

	| bar |
	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	bar
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color veryDarkGray).
	^ bar
]

{ #category : #'as yet unclassified' }
Game class >> menuGrid [
	"Menu de choix de la taille de grille"

	|menu|
	menu := ToMenu new.
	
	menu label: (ToLabel text: 'Grid').
		menu icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #solidMenu)).
		
	menu addItem:
		((ToButtonMenuItem new labelText: '4x4') whenClickedDo: [
			 BoardElement launch4 ]).
		
	menu addItem:
		((ToButtonMenuItem new labelText: '6x6') whenClickedDo: [
			 BoardElement launch6 ]).
		
	^ menu
]

{ #category : #'instance creation' }
Game class >> open [
	"Les éléments à afficher dans la page d'accueil"
	
		| space gridMenu title bar |

	gridMenu	:= self menuGrid.
	bar := self menuBar.
	title := self title.
	
	"Les elements de la barre haute de l'acceuil"
	bar addMenu: gridMenu .
	space := BlSpace new.
	
	space root addChild: bar.
	space root addChild: title.
	space extent: 500 @ 500.
	space show
	 								
									
								
]

{ #category : #accessing }
Game class >> title [ 
	"Affichage de la titre de la page d'acceuil"
	
	|title|
	title := BlElement new background: Color lightBlue.
	title constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	title layout: BlFrameLayout new.
	title addChild: ((BlTextElement new text:
			  (('2048 GAME' asRopedText fontName: 'Phosphate') fontSize: 50))
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
	^ title 
]
