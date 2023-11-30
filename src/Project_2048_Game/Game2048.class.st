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
Game2048 >> findNextTileUpForRow: initialRow col: col [
    | row nextTile |
    row := initialRow.
    nextTile := nil.
    
    [ (row := row - 1) >= 1 ] whileTrue: [
        | currentTile |
        currentTile := self tileAtRow: row col: col.
        currentTile isNotNil ifTrue: [
            nextTile := currentTile.
            ^ nextTile
        ].
    ].
    
    ^ nextTile
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
            grid at: i at: j put: nil. "grid at: i at: j put: (Tile value: 0)."
        ]
    ].
]

{ #category : #accessing }
Game2048 >> moveUp [

	| moved |
    moved := false.

    "Iterer à travers chaque colonne"
    1 to: gridSize do: [ :col |
        | currentRow nextRow |
        currentRow := 1.

        "Itérer de haut en bas de la grille dans la colonne actuelle"
        [currentRow <= gridSize] whileTrue: [
            | currentTile nextTile |
            currentTile := self tileAtRow: currentRow col: col.
            nextRow := currentRow + 1.

            "Itérer pour trouver la prochaine tuile non-nil au-dessus de la tuile actuelle"
            [nextRow <= gridSize] whileTrue: [
                nextTile := self tileAtRow: nextRow col: col.

                nextTile isNil ifTrue: [
                    "Si la tuile suivante est nil, déplacez la tuile actuelle vers le haut"
                    nextRow := nextRow + 1.
                    moved := true.
                    currentTile := nil. "setValue: nil."
                ] ifFalse: [
                    "Si la tuile suivante n'est pas nil"
                    nextTile value = currentTile value ifTrue: [
                        "Si les deux tuiles ont la même valeur, fusionnez-les"
                        nextTile setValue: (nextTile value * 2).
                        currentTile setValue: nil.
                        moved := true.
                        nextRow := gridSize + 1.  "Sortir de la boucle"
                    ] ifFalse: [
                        "Si les tuiles sont différentes, sortir de la boucle"
                        nextRow := gridSize + 1.  "Sortir de la boucle"
                    ].
                ].
            ].
            currentRow := currentRow + 1.
        ].
    ].

    ^ moved ifTrue: [grid] ifFalse: [self].
]

{ #category : #accessing }
Game2048 >> setTileAtRow: row col: col value: value [

    grid at: row at: col put: value
]

{ #category : #accessing }
Game2048 >> tileAtRow: row col: col [

    ^ grid at: row at: col
]
