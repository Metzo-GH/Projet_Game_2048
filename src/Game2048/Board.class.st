Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'grid'
	],
	#category : #Game2048
}

{ #category : #translating }
Board class >> generateWithSize: aNumber [

	^ (self newSquaredSize: aNumber)
		  initializeRandomized;
		  yourself
]

{ #category : #translating }
Board class >> newSquaredSize: aNumber [

	^ self new
		  configureGrid: (CTNewArray2D
				   width: aNumber
				   height: aNumber
				   tabulate: [ :x :y | TFixedBox createBoxWithValue: nil ])
]

{ #category : #'public api - configure' }
Board >> configureGrid: anArray2D [
	"anArray@d is filled up with elements. Make sure that each element has is backpointer set to the board."
	
	self grid: anArray2D.
	grid withIndexes: [ :column :row |
		(grid at: column @ row) position: column @ row;
		board: self   ]
]

{ #category : #'public api - configure' }
Board >> grid [ 
	^ grid 
]

{ #category : #'public api - configure' }
Board >> grid: anArray2D [
	
	grid := anArray2D.
	
]
