Class {
	#name : #Game2048ElementTransition,
	#superclass : #Object,
	#instVars : [
		'duration',
		'easing',
		'animation'
	],
	#category : #'Project_2048_Game_UI'
}

{ #category : #accessing }
Game2048ElementTransition >> animation [

	^ animation
]

{ #category : #accessing }
Game2048ElementTransition >> animation: aBlAnimation [

	self isRunning ifTrue: [ self notYetImplemented ].

	animation := aBlAnimation
]

{ #category : #accessing }
Game2048ElementTransition >> duration [

	^ duration
]

{ #category : #accessing }
Game2048ElementTransition >> duration: aDuration [

	aDuration isZero ifTrue: [ self notYetImplemented ].
	self isRunning ifTrue: [ self notYetImplemented ].

	duration := aDuration
]

{ #category : #accessing }
Game2048ElementTransition >> easing [

	^ easing
]

{ #category : #accessing }
Game2048ElementTransition >> easing: aBlInterpolator [

	self isRunning ifTrue: [ self notYetImplemented ].

	easing := aBlInterpolator
]

{ #category : #accessing }
Game2048ElementTransition >> initialize [

	super initialize.

	duration := 0 seconds.
	easing := BlLinearInterpolator default
]

{ #category : #accessing }
Game2048ElementTransition >> isRunning [

	^ animation isNotNil and: [ animation isRunning ]
]
