Class {
	#name : #GAME2048LabelElement,
	#superclass : #Game2048Elements,
	#instVars : [
		'label'
	],
	#category : #'Project_2048_Game_UI'
}

{ #category : #initialization }
GAME2048LabelElement >> initialize [

	super initialize.

	label := BlTextElement new.

	self addChild: label as: #label
]

{ #category : #initialization }
GAME2048LabelElement >> label [

	^ label
]

{ #category : #initialization }
GAME2048LabelElement >> text: aBlRopedText [

	label text: aBlRopedText
]
