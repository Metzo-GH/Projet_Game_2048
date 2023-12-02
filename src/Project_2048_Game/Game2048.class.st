Class {
	#name : #Game2048,
	#superclass : #Object,
	#instVars : [
		'gridSize',
		'grid'
	],
	#category : #'Project_2048_Game'
}

{ #category : #'as yet unclassified' }
Game2048 class >> gridSize: size [

	^ self new gridSize: size
]

{ #category : #accessing }
Game2048 >> emptyTileAtColumn: column row: emptyTileRow [

    | tileAtIndex |
    tileAtIndex := grid at: emptyTileRow at: column.
    tileAtIndex value ifNil: [ ^ emptyTileRow ].
    

    ^ nil. "Aucune tuile vide trouvée"

]

{ #category : #accessing }
Game2048 >> grid [
	
	^ grid
]

{ #category : #accessing }
Game2048 >> grid: aGrid [ 

	grid := aGrid 
]

{ #category : #accessing }
Game2048 >> gridSize: size [
        
	^ self initializeGameWithSize: size
]

{ #category : #accessing }
Game2048 >> initializeGameWithSize: size [
       
	gridSize := size.
	grid := Array2D rows: gridSize columns: gridSize.

	self initializeGrid.
]

{ #category : #accessing }
Game2048 >> initializeGrid [

	1 to: gridSize by: 1 do: [ :i |
		1 to: gridSize by: 1 do: [ :j |
            grid at: i at: j put: (Tile value: nil).
        ]
    ].
]

{ #category : #accessing }
Game2048 >> mergeTilesInColumn: column [
	"Fusionner les tuiles"

    | index tilesMerged |
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
					grid at: index at: column put: (Tile value: nil).
               tilesMerged := true.
            ]
        ].
        index := index - 1.
    ].

]

{ #category : #accessing }
Game2048 >> moveDown [ 
    "Faire le mouvement vers le bas colonne par colonne"

    gridSize to: 1 by: -1 do: [ :column |
        self moveTilesDownInColumn: column.
        self mergeTilesInColumn: column.
        self moveTilesDownInColumn: column.
    ].

]

{ #category : #accessing }
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
                    grid at: row at: column put: (Tile value: nil).
                    emptyTileIndex := row.
                ].
            ].
        ].
    ].

]

{ #category : #accessing }
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
					emptyTileRow isNotNil ifTrue:  [ emptyTileIndex := row ].
				].
            		emptyTileRow ifNotNil: [
						"Remonter la tuile"
						grid at: emptyTileRow at: column put: (Tile value: currentTile value).
						grid at: row at: column put: (Tile value: nil).
            		].
			  
        ].
    ].

]

{ #category : #accessing }
Game2048 >> moveUp [
	"Faire le moveUp colonne par colonne"
	
    1 to: gridSize do: [ :column |
        self moveTilesUpInColumn: column.
        self mergeTilesInColumn: column.
        self moveTilesUpInColumn: column.
    ].
]
