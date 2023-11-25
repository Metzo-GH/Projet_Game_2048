Class {
	#name : #Board,
	#superclass : #Object,
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
