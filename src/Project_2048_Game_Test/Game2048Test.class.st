Class {
	#name : #Game2048Test,
	#superclass : #TestCase,
	#category : #'Project_2048_Game_Test'
}

{ #category : #tests }
Game2048Test >> testMoveUp [

        | game flattenedGrid |
        
        "Création d'une instance du jeu 2048 avec la grille de test"
        game := Game2048 new.
        game gridSize: 4.

			game grid at: 1 at: 1 put: (Tile value: 2).
			game grid at: 1 at: 2 put: (Tile value: 0).
			game grid at: 1 at: 3 put: (Tile value: 2).
			game grid at: 1 at: 4 put: (Tile value: 0).
			game grid at: 2 at: 1 put: (Tile value: 4).
			game grid at: 2 at: 2 put: (Tile value: 2).
			game grid at: 2 at: 3 put: (Tile value: 0).
			game grid at: 2 at: 4 put: (Tile value: 2).
			game grid at: 3 at: 1 put: (Tile value: 0).
			game grid at: 3 at: 2 put: (Tile value: 4).
			game grid at: 3 at: 3 put: (Tile value: 2).
			game grid at: 3 at: 4 put: (Tile value: 4).
			game grid at: 4 at: 1 put: (Tile value: 2).
			game grid at: 4 at: 2 put: (Tile value: 0).
			game grid at: 4 at: 3 put: (Tile value: 0).
			game grid at: 4 at: 4 put: (Tile value: 2).

        "Appel de la méthode moveUp"
        game moveUp.

        "Vérification du résultat attendu après le déplacement"
			flattenedGrid := OrderedCollection new.
			1 to: 4 do: [ :i |
    				1 to: 4 do: [ :j |
        | tileValue |
        	tileValue := (game grid at: i at: j) ifNotNil: [ :tile |
				 tile value ] ifNil: [ nil ].
        flattenedGrid add: tileValue.
    			].
			].

self assert: flattenedGrid asArray equals: #(2 2 4 2 4 4 0 4 2 0 0 2 0 0 0 0).
]
