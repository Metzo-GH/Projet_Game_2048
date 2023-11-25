Class {
	#name : #BoardElement,
	#superclass : #Object,
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
