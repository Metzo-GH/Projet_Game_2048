Class {
	#name : #Game2048Skin,
	#superclass : #Object,
	#category : #'Project_2048_Game_UI'
}

{ #category : #applying }
Game2048Skin >> applyGameSkinOn: aGameElement [ 

	aGameElement
		background: Color lightGray darker;
		constraintsDo: [ :aLayoutConstraints | 
			aLayoutConstraints horizontal matchParent.
			aLayoutConstraints vertical matchParent ].

	aGameElement tilesContainer
		constraintsDo: [ :aLayoutConstraints | 
			aLayoutConstraints horizontal matchParent.
			aLayoutConstraints vertical matchParent ].

	aGameElement slotsContainer
		constraintsDo: [ :aLayoutConstraints | 
			aLayoutConstraints horizontal matchParent.
			aLayoutConstraints vertical matchParent ]

]

{ #category : #applying }
Game2048Skin >> applySlotSkinOn: aSlotElement [

	aSlotElement
		size: 75 asPoint;
		margin: (BlInsets all: 3);
		background: Color paleOrange;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3).
]

{ #category : #applying }
Game2048Skin >> applyTileSkinOn: aTileElement [

	aTileElement
		layout: BlLinearLayout new alignCenter;
		size: 75 asPoint;
		background: Color paleYellow;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3).

	"Animate translations"
	(aTileElement transitionAt: #transformation)
		duration: 0.2 seconds;
		easing: BlQuinticInterpolator default.

	aTileElement label defaultFontSize: 28.
]
