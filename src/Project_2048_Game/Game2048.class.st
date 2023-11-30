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
            grid at: i at: j put: (Tile value: 0).
        ]
    ].
]

{ #category : #accessing }
Game2048 >> moveUp [

    1 to: gridSize do: [ :col | 
        | merged |
        merged := false.
        (gridSize - 1) to: 2 by: -1 do: [ :row |
            | currentTile |
            currentTile := grid at: row at: col.
            currentTile ifNotNil: [
                | nextEmptyRow |
                nextEmptyRow := row.
                [nextEmptyRow > 1] whileTrue: [
                    | nextTile |
                    nextTile := grid at: (nextEmptyRow - 1) at: col.
                    nextTile ifNil: [
                        nextEmptyRow := nextEmptyRow - 1.
                    ] ifNotNil: [
                        (nextTile value = currentTile value and: [merged not]) ifTrue: [
                            nextTile doubleValue.
                            grid at: nextEmptyRow at: col put: nil.
                            merged := true.
                        ] ifFalse: [
                            nextEmptyRow := 0.
                        ].
                    ].
                ].
                nextEmptyRow > 0 ifTrue: [
                    grid at: nextEmptyRow at: col put: currentTile.
                    grid at: row at: col put: nil.
                ].
            ].
        ].
    ].
]

{ #category : #accessing }
Game2048 >> setTileAtRow: row col: col value: value [
       
	(grid at: ((row - 1) * gridSize + col)) setValue: value
]

{ #category : #accessing }
Game2048 >> tileAtRow: row col: col [
       
	^ (grid at: ((row - 1) * gridSize + col)) value
]
