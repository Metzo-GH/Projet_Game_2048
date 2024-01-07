Class {
	#name : #Game2048Skin,
	#superclass : #Object,
	#category : #'Project_2048_Game_UI'
}

{ #category : #applying }
Game2048Skin >> applyGameSkinOn: aGameElement [ 

	aGameElement
		background: Color black;
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
		size: 143 asPoint;
		margin: (BlInsets all: 3);
		background: Color veryLightGray ;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3).
]

{ #category : #applying }
Game2048Skin >> applyTileSkinOn: aTileElement setColor: aColor [

	aTileElement
		layout: BlLinearLayout new alignCenter;
		size: 143 asPoint;
		background: aColor asColor ;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3).

	"Animate translations"
	(aTileElement transitionAt: #transformation)
		duration: 0.5 seconds;
		easing: BlQuinticInterpolator default.

	aTileElement label defaultFontSize: 50.
]
