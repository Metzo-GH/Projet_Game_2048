Class {
	#name : #Game2048,
	#superclass : #Object,
	#instVars : [
		'gridSize',
		'grid',
		'score',
		'tilesMerged',
		'randomRow',
		'randomCol'
	],
	#category : #'Project_2048_Game'
}

{ #category : #'not defined category' }
Game2048 class >> gridSize: size [

	self new gridSize: size
]

{ #category : #'initialize the grid' }
Game2048 >> addTileAtRandom [
	
	| count |
	
	randomRow := (1 to: gridSize) atRandom.
	randomCol := (1 to: gridSize) atRandom.
	count := 0.

	[(grid at: randomRow at: randomCol) notNil and: [count < 50]] whileTrue: [
    	randomRow := (1 to: gridSize) atRandom.
    	randomCol := (1 to: gridSize) atRandom.
    	count := count + 1.
	].

	(grid at: randomRow at: randomCol) ifNil: [
    	grid at: randomRow at: randomCol put: (Tile value: 2).
	].

]

{ #category : #'Tile Move' }
Game2048 >> determineScore [

	tilesMerged ifTrue: [
		1 to: gridSize by: 1 do: [ :row |
			1 to: gridSize by: 1 do: [ :col |
				(grid at: row at: col) value ifNotNil: [ 
					(((grid at: row at: col) value) > score) ifTrue: [ 
					score := (grid at: row at: col) value 
				 		] 
					]
				] 
			] 
		]
]

{ #category : #'Tile Move' }
Game2048 >> emptyTileAtColumn: column row: emptyTileRow [

    | tileAtIndex |
    tileAtIndex := grid at: emptyTileRow at: column.
    tileAtIndex value ifNil: [ ^ emptyTileRow ].
    

    ^ nil. "Aucune tuile vide trouvée"

]

{ #category : #'initialize the grid' }
Game2048 >> grid [
	
	^ grid
]

{ #category : #'initialize the grid' }
Game2048 >> grid: aGrid [ 

	grid := aGrid 
]

{ #category : #'initialize the grid' }
Game2048 >> gridSize [

	^ gridSize
]

{ #category : #'initialize the grid' }
Game2048 >> gridSize: size [
        
	self initializeGameWithSize: size
]

{ #category : #'initialize the grid' }
Game2048 >> initializeGameWithSize: size [
       
	gridSize := size.
	grid := Array2D rows: gridSize columns: gridSize.
	
	score := 2.

	self initializeGrid.
]

{ #category : #'initialize the grid' }
Game2048 >> initializeGrid [
	
	self addTileAtRandom.
	
	1 to: gridSize by: 1 do: [ :i |
		1 to: gridSize by: 1 do: [ :j |
				(grid at: i at: j) ifNil: 
					[grid at: i at: j put: nil] 
        ]
    ].
]

{ #category : #'Tile Move' }
Game2048 >> mergeTilesInColumn: column [
	"Fusionner les tuiles"

    | index |
    index := gridSize.
    tilesMerged := false.

    [ index > 1 and: [ tilesMerged not ] ] whileTrue: [
        | currentTile nextTile |
        currentTile := grid at: index at: column.
        nextTile := grid at: index - 1 at: column.

        currentTile value ifNotNil: [
            (currentTile value = nextTile value) ifTrue: [
					nextTile := currentTile value * 2.
					grid at: index - 1 at: column put: (Tile value: nextTile value).
					grid at: index at: column put: nil.
               tilesMerged := true.
            ]
        ].
        index := index - 1.
    ].


]

{ #category : #'Tile Move' }
Game2048 >> mergeTilesInRow: row [ 
    "Fusionner les tuiles dans une ligne spécifique vers la droite"

    | index |
    index := gridSize.
    tilesMerged := false.

    [ index > 1 and: [ tilesMerged not ] ] whileTrue: [
        | currentTile nextTile |
        currentTile := grid at: row at: index.
        nextTile := grid at: row at: index - 1.

        currentTile value ifNotNil: [
            (currentTile value = nextTile value) ifTrue: [
                nextTile := currentTile value * 2.
                grid at: row at: index - 1 put: (Tile value: nextTile value).
                grid at: row at: index put: nil.
                tilesMerged := true.
            ]
        ].
        index := index - 1.
    ].

]

{ #category : #'Tile Move' }
Game2048 >> moveDown [ 
    "Faire le mouvement vers le bas colonne par colonne"

    gridSize to: 1 by: -1 do: [ :column |
        self moveTilesDownInColumn: column.
        self mergeTilesInColumn: column.
        self moveTilesDownInColumn: column.
    ].

	
	
]

{ #category : #'Tile Move' }
Game2048 >> moveLeft [
    "Faire le mouvement vers la droite ligne par ligne"

    1 to: gridSize do: [ :row |
        self moveTilesLeftInRow: row.
        self mergeTilesInRow: row.
        self moveTilesLeftInRow: row.
    ].


]

{ #category : #'Tile Move' }
Game2048 >> moveRight [ 
    "Faire le mouvement vers la droite ligne par ligne"

    gridSize to: 1 by: -1 do: [ :row |
        self moveTilesRightInRow: row.
        self mergeTilesInRow: row.
        self moveTilesRightInRow: row.
    ].


]

{ #category : #'Tile Move' }
Game2048 >> moveTilesDownInColumn: column [ 
    "Descendre les tuiles dans une colonne spécifique"

    gridSize to: 1 by: -1 do: [ :row | "Parcourir chaque ligne de la colonne en partant du bas"
        | currentTile emptyTileRow emptyTileIndex |
        emptyTileIndex := gridSize.
        currentTile := grid at: row at: column.
        currentTile value ifNotNil: [
            "Chercher la prochaine tuile vide pour déplacer la tuile actuelle"
            [ emptyTileIndex > row ] whileTrue: [
                emptyTileRow := self emptyTileAtColumn: column row: emptyTileIndex.
                emptyTileRow ifNil: [ emptyTileIndex := emptyTileIndex - 1 ].
                emptyTileRow ifNotNil: [
                    "Descendre la tuile"
                    grid at: emptyTileRow at: column put: (Tile value: currentTile value).
                    grid at: row at: column put:  nil.
                    emptyTileIndex := row.
                ].
            ].
        ].
    ].

]

{ #category : #'Tile Move' }
Game2048 >> moveTilesLeftInRow: row [
    "Déplacer les tuiles vers la Gauche"

    1 to: gridSize do: [ :column | "Parcourir chaque colonne de la ligne, en partant de la gauche" 
        | currentTile emptyTileColumn |
        emptyTileColumn := 1.
        currentTile := grid at: row at: column.
        currentTile value ifNotNil: [
            [ emptyTileColumn < column ] whileTrue: [
                (self emptyTileAtColumn: emptyTileColumn row: row) ifNotNil: [
                    "Déplacer la tuile vers la gauche"
                    grid at: row at: emptyTileColumn put: (Tile value: currentTile value).
                    grid at: row at: column put:  nil.
                    emptyTileColumn := column. "Sortir de la boucle"
                ] ifNil: [
                    emptyTileColumn := emptyTileColumn + 1.
                ].
            ].
        ].
    ].

]

{ #category : #'Tile Move' }
Game2048 >> moveTilesRightInRow: row [
    "Déplacer les tuiles vers la droite dans une ligne spécifique"

    gridSize to: 1 by: -1 do: [ :column | "Parcourir chaque colonne de la ligne, en partant de la droite" 
        | currentTile emptyTileColumn |
        emptyTileColumn := gridSize.
        currentTile := grid at: row at: column.
        currentTile value ifNotNil: [
            [ emptyTileColumn > column ] whileTrue: [
                (self emptyTileAtColumn: emptyTileColumn row: row) ifNotNil: [
                    "Déplacer la tuile vers la droite"
                    grid at: row at: emptyTileColumn put: (Tile value: currentTile value).
                    grid at: row at: column put: nil.
                    emptyTileColumn := column. "Sortir de la boucle"
                ] ifNil: [
                    emptyTileColumn := emptyTileColumn - 1.
                ].
            ].
        ].
    ].

]

{ #category : #'Tile Move' }
Game2048 >> moveTilesUpInColumn: column [
	"Monter les tuiles de la grille"
    
    1 to: gridSize do: [ :row | "Parcourir chaque ligne de la colonne"
        | currentTile emptyTileRow emptyTileIndex |
			emptyTileIndex := 1.
        	currentTile := grid at: row at: column.
        	currentTile value ifNotNil: [
			"Chercher la prochaine tuile nul pour remplacer sa valeur"
			  [ emptyTileIndex < row ] whileTrue: [ 
            		emptyTileRow := self emptyTileAtColumn: column row: emptyTileIndex.
					emptyTileRow ifNil: [ emptyTileIndex := emptyTileIndex + 1. ].
					emptyTileRow ifNotNil:  [ emptyTileIndex := row ].
				].
            		emptyTileRow ifNotNil: [
						"Remonter la tuile"
						grid at: emptyTileRow at: column put: (Tile value: currentTile value).
						grid at: row at: column put: nil.
            		].
			  
        ].
		
    ].

]

{ #category : #'Tile Move' }
Game2048 >> moveUp [
	"Faire le moveUp colonne par colonne"
	
	
    1 to: gridSize do: [ :column |
        self moveTilesUpInColumn: column.
        self mergeTilesInColumn: column.
        self moveTilesUpInColumn: column.
    ].



]

{ #category : #'Tile Move' }
Game2048 >> score [

	^ score
]
