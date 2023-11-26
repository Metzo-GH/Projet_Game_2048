Class {
	#name : #BoardElement,
	#superclass : #BlElement,
	#instVars : [
		'board'
	],
	#category : #Game2048
}

{ #category : #'as yet unclassified' }
BoardElement class >> launch4 [

	^ self openWithModel: (TBoard generateWithSize: 4)
]

{ #category : #'as yet unclassified' }
BoardElement class >> launch6 [

	^ self openWithModel: (TBoard generateWithSize: 6)
]

{ #category : #'as yet unclassified' }
BoardElement class >> openWithModel: aTField [

	| aFieldElement space |
	space := BlSpace new.
	aFieldElement := self new
		                 board: aTField;
		                 yourself.
	space root addChild: aFieldElement.
	space pulse
		extent: 500 @ 500;
		resizable: false;
		show
]

{ #category : #accessing }
BoardElement >> board [

	^board 
]

{ #category : #accessing }
BoardElement >> board: aTBoard [

	board := aTBoard.
	self layout:
		(BlGridLayout horizontal cellSpacing: 5 - (board grid width // 5)).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal matchParent.
		aLayoutConstraints vertical matchParent ].
	self padding: (BlInsets all: 5).
	self layout columnCount: board grid width.
	board grid do: [ :aBox |
		| boxElement |
		boxElement := (TBoxElement box: aBox) board: aTBoard.
		self addChild: boxElement ]
]
