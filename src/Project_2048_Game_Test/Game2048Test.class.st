Class {
	#name : #Game2048Test,
	#superclass : #TestCase,
	#category : #'Project_2048_Game_Test'
}

{ #category : #tests }
Game2048Test >> testCombineDown [

	| game |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 3 at: 1 put: (Tile value: 4).
	game grid at: 4 at: 1 put: (Tile value: 4).

	"Effectuer un move"
	game moveDown.

	self assert: (game grid at: 4 at: 1) value equals: 8
]

{ #category : #tests }
Game2048Test >> testCombineLeft [

	| game |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 1 put: (Tile value: 8).
	game grid at: 1 at: 2 put: (Tile value: 8).

	"Effectuer un move"
	game moveLeft.

	self assert: (game grid at: 1 at: 1) value equals: 16
]

{ #category : #tests }
Game2048Test >> testCombineRight [

	| game |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 3 put: (Tile value: 32).
	game grid at: 1 at: 4 put: (Tile value: 32).

	"Effectuer un move"
	game moveRight.

	self assert: (game grid at: 1 at: 4) value equals: 64
]

{ #category : #tests }
Game2048Test >> testCombineUp [

	| game |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 1 put: (Tile value: 2).
	game grid at: 2 at: 1 put: (Tile value: 2).

	"Effectuer un move"
	game moveUp.

	self assert: (game grid at: 1 at: 1) value equals: 4
]

{ #category : #tests }
Game2048Test >> testMoveDown [

	| game flattenedGrid |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 1 put: (Tile value: 2).
	game grid at: 1 at: 2 put: (Tile value: nil).
	game grid at: 1 at: 3 put: (Tile value: 2).
	game grid at: 1 at: 4 put: (Tile value: nil).
	game grid at: 2 at: 1 put: (Tile value: 4).
	game grid at: 2 at: 2 put: (Tile value: 2).
	game grid at: 2 at: 3 put: (Tile value: nil).
	game grid at: 2 at: 4 put: (Tile value: 2).
	game grid at: 3 at: 1 put: (Tile value: nil).
	game grid at: 3 at: 2 put: (Tile value: 4).
	game grid at: 3 at: 3 put: (Tile value: 2).
	game grid at: 3 at: 4 put: (Tile value: 4).
	game grid at: 4 at: 1 put: (Tile value: 2).
	game grid at: 4 at: 2 put: (Tile value: nil).
	game grid at: 4 at: 3 put: (Tile value: nil).
	game grid at: 4 at: 4 put: (Tile value: 2).

	"Effectuer un moveUp"
	game moveDown.


	"Vérification du résultat attendu après le déplacement"
	flattenedGrid := OrderedCollection new.
	1 to: 4 do: [ :i |
		1 to: 4 do: [ :j |
			| tileValue |
			tileValue := (game grid at: i at: j)
				             ifNotNil: [ :tile | tile value ]
				             ifNil: [ nil ].
			flattenedGrid add: tileValue ] ].

	self
		assert: flattenedGrid asArray
		equals: #( nil nil nil nil 2 nil nil 2 4 2 nil 4 2 4 4 2 )
]

{ #category : #tests }
Game2048Test >> testMoveLeft [

	| game flattenedGrid |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 1 put: (Tile value: 2).
	game grid at: 1 at: 2 put: (Tile value: nil).
	game grid at: 1 at: 3 put: (Tile value: 2).
	game grid at: 1 at: 4 put: (Tile value: nil).
	game grid at: 2 at: 1 put: (Tile value: 4).
	game grid at: 2 at: 2 put: (Tile value: 2).
	game grid at: 2 at: 3 put: (Tile value: nil).
	game grid at: 2 at: 4 put: (Tile value: 2).
	game grid at: 3 at: 1 put: (Tile value: nil).
	game grid at: 3 at: 2 put: (Tile value: 4).
	game grid at: 3 at: 3 put: (Tile value: 2).
	game grid at: 3 at: 4 put: (Tile value: 4).
	game grid at: 4 at: 1 put: (Tile value: 2).
	game grid at: 4 at: 2 put: (Tile value: nil).
	game grid at: 4 at: 3 put: (Tile value: nil).
	game grid at: 4 at: 4 put: (Tile value: 2).

	"Effectuer un moveUp"
	game moveLeft.


	"Vérification du résultat attendu après le déplacement"
	flattenedGrid := OrderedCollection new.
	1 to: 4 do: [ :i |
		1 to: 4 do: [ :j |
			| tileValue |
			tileValue := (game grid at: i at: j)
				             ifNotNil: [ :tile | tile value ]
				             ifNil: [ nil ].
			flattenedGrid add: tileValue ] ].

	self
		assert: flattenedGrid asArray
		equals: #( 4 nil nil nil 4 4 nil nil 4 2 4 nil 4 nil nil nil )
]

{ #category : #tests }
Game2048Test >> testMoveRight [

	| game flattenedGrid |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 1 put: (Tile value: 2).
	game grid at: 1 at: 2 put: (Tile value: nil).
	game grid at: 1 at: 3 put: (Tile value: 2).
	game grid at: 1 at: 4 put: (Tile value: nil).
	game grid at: 2 at: 1 put: (Tile value: 4).
	game grid at: 2 at: 2 put: (Tile value: 2).
	game grid at: 2 at: 3 put: (Tile value: nil).
	game grid at: 2 at: 4 put: (Tile value: 2).
	game grid at: 3 at: 1 put: (Tile value: nil).
	game grid at: 3 at: 2 put: (Tile value: 4).
	game grid at: 3 at: 3 put: (Tile value: 2).
	game grid at: 3 at: 4 put: (Tile value: 4).
	game grid at: 4 at: 1 put: (Tile value: 2).
	game grid at: 4 at: 2 put: (Tile value: nil).
	game grid at: 4 at: 3 put: (Tile value: nil).
	game grid at: 4 at: 4 put: (Tile value: 2).

	"Effectuer un moveUp"
	game moveRight.


	"Vérification du résultat attendu après le déplacement"
	flattenedGrid := OrderedCollection new.
	1 to: 4 do: [ :i |
		1 to: 4 do: [ :j |
			| tileValue |
			tileValue := (game grid at: i at: j)
				             ifNotNil: [ :tile | tile value ]
				             ifNil: [ nil ].
			flattenedGrid add: tileValue ] ].

	self
		assert: flattenedGrid asArray
		equals: #( nil nil nil 4 nil nil 4 4 nil 4 2 4 nil nil nil 4 )
]

{ #category : #tests }
Game2048Test >> testMoveUp [

	| game flattenedGrid |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 1 put: (Tile value: 2).
	game grid at: 1 at: 2 put: (Tile value: nil).
	game grid at: 1 at: 3 put: (Tile value: 2).
	game grid at: 1 at: 4 put: (Tile value: nil).
	game grid at: 2 at: 1 put: (Tile value: 4).
	game grid at: 2 at: 2 put: (Tile value: 2).
	game grid at: 2 at: 3 put: (Tile value: nil).
	game grid at: 2 at: 4 put: (Tile value: 2).
	game grid at: 3 at: 1 put: (Tile value: nil).
	game grid at: 3 at: 2 put: (Tile value: 4).
	game grid at: 3 at: 3 put: (Tile value: 2).
	game grid at: 3 at: 4 put: (Tile value: 4).
	game grid at: 4 at: 1 put: (Tile value: 2).
	game grid at: 4 at: 2 put: (Tile value: nil).
	game grid at: 4 at: 3 put: (Tile value: nil).
	game grid at: 4 at: 4 put: (Tile value: 2).

	"Effectuer un moveUp"
	game moveUp.


	"Vérification du résultat attendu après le déplacement"
	flattenedGrid := OrderedCollection new.
	1 to: 4 do: [ :i |
		1 to: 4 do: [ :j |
			| tileValue |
			tileValue := (game grid at: i at: j)
				             ifNotNil: [ :tile | tile value ]
				             ifNil: [ nil ].
			flattenedGrid add: tileValue ] ].

	self
		assert: flattenedGrid asArray
		equals: #( 2 2 4 2 4 4 nil 4 2 nil nil 2 nil nil nil nil )
]

{ #category : #tests }
Game2048Test >> testScore [

	| game |
	"Création d'une instance du jeu 2048 avec la grille de test"
	game := Game2048 new.
	game gridSize: 4.

	game grid at: 1 at: 3 put: (Tile value: 32).
	game grid at: 1 at: 4 put: (Tile value: 32).
	game grid at: 2 at: 3 put: (Tile value: 2).
	game grid at: 2 at: 4 put: (Tile value: 2).

	"Effectuer un move"
	game moveRight.
	game determineScore.

	self assert: game score value equals: 64.
	self assert: (game grid at: 1 at: 4) value equals: 64.
	self assert: (game grid at: 2 at: 4) value equals: 4
]

{ #category : #tests }
Game2048Test >> testifLose [

	| game tileValues rowIndex colIndex |
	game := Game2048 new.
	game gridSize: 4.

	tileValues := #( 4 8 4 8 8 4 8 4 4 8 4 8 8 4 8 4 ).
	rowIndex := 1.
	colIndex := 1.

	tileValues do: [ :value |
		game grid at: rowIndex at: colIndex put: (Tile value: value).
		colIndex := colIndex + 1.
		rowIndex := colIndex > game gridSize
			            ifTrue: [
				            colIndex := 1.
				            rowIndex + 1 ]
			            ifFalse: [ rowIndex ] ].

	self assert: game ifLose
]

{ #category : #tests }
Game2048Test >> testifWin [

	| game |
	game := Game2048 new.
	game gridSize: 4.

	"Placer une tuile de 2048 dans la grille"
	game grid at: 1 at: 1 put: (Tile value: 2048).

	"Vérifier si le joueur a gagné après l'insertion de la tuile 2048"
	self assert: game ifWin
]
