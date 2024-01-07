Class {
	#name : #Game2048Elements,
	#superclass : #BlElement,
	#instVars : [
		'transitionByName'
	],
	#category : #'Project_2048_Game_UI'
}

{ #category : #initialization }
Game2048Elements >> initialize [

	super initialize.
	
	transitionByName := Dictionary new.
	
]

{ #category : #initialization }
Game2048Elements >> newTransformationAnimationFrom: startElementTransformation to: endElementTransformation [

	| cachedTransformation fromMatrix toMatrix |
	cachedTransformation :=
		endElementTransformation asCachedTransformation.
	cachedTransformation boundingRectangle:
		self bounds inLocal asRectangle.

	fromMatrix := startElementTransformation matrix copy.
	toMatrix := cachedTransformation matrix.

"	toMatrix = fromMatrix ifTrue: [ 'same matrix!' traceCr ]."

	^ BlNumberTransition new
			from: 0.0;
			to: 1.0;
			onStepDo: [ :f |
				super transformation:
					(BlElementAbsoluteTransformation matrix:
						(fromMatrix interpolate: f to: toMatrix)) ];
			yourself
]

{ #category : #initialization }
Game2048Elements >> opacity: aNumber [

	| aTransition anAnimation |
	aNumber = self opacity ifTrue: [ ^self ].

	aTransition := transitionByName
		at: #opacity
		ifAbsent: [ ^ super opacity: aNumber ].
	
	aTransition duration isZero ifTrue: [
		^ super opacity: aNumber ].

	aTransition isRunning ifTrue: [
		self notYetImplemented ].

	anAnimation :=
		(self newOpacityAnimationFrom: self opacity to: aNumber)
			duration: aTransition duration;
			easing: aTransition easing;
			yourself.

	aTransition animation: anAnimation.
	self addAnimation: anAnimation
]

{ #category : #initialization }
Game2048Elements >> transformation: anElementTransformation [

	| aTransition |

	aTransition := transitionByName
		at: #transformation
		ifAbsent: [ ^ super transformation: anElementTransformation ].
	
	aTransition isRunning ifTrue: [
		self notYetImplemented ].

	self whenLayoutedDoOnce: [
		| anAnimation |
		anAnimation :=
			(self
				newTransformationAnimationFrom: self transformation
				to: anElementTransformation)
					duration: aTransition duration;
					easing: aTransition easing;
					yourself.

		aTransition animation: anAnimation.
		self addAnimation: anAnimation ]
]

{ #category : #initialization }
Game2048Elements >> transitionAt: aName [

	^ transitionByName
			at: aName
			ifAbsentPut: [ Game2048ElementTransition new ]
]

{ #category : #initialization }
Game2048Elements >> transitionAt: aName duration: aDuration [

	(self transitionAt: aName) duration: aDuration

]

{ #category : #initialization }
Game2048Elements >> transitionAt: aName easing: aBlInterpolator [

	(self transitionAt: aName) easing: aBlInterpolator
]
