Class {
	#name : #TileElement,
	#superclass : #Game2048Element,
	#instVars : [
		'label'
	],
	#category : #'Project_2048_Game-UI'
}

{ #category : #initialization }
TileElement >> initialize [

	super initialize.

	self
		addChild: (label := BlTextElement new)
		as: #label
]

{ #category : #initialization }
TileElement >> text: aBlRopedText [
	
	label text: aBlRopedText
]
