Class {
	#name : #GameElement,
	#superclass : #Game2048Element,
	#instVars : [
		'game',
		'tilesContainer',
		'slotsContainer',
		'elementByTile',
		'keyBindingsEventHandler',
		'mouseWheelEventHandler',
		'isSlideEnabled',
		'slotElementMatrix'
	],
	#category : #'Project_2048_Game-UI'
}

{ #category : #examples }
GameElement class >> example2048 [

	self exampleFor: GCGame new
]

{ #category : #examples }
GameElement class >> exampleFor: game [

	| gameElement space skin |
	
	gameElement := GCGameElement new
		game: game;
		yourself.
	space := BlSpace new.

	skin := game variant skinClass on: gameElement.
	space root whenLayoutedDo: [ :evt | skin applyToNewElements ].

	space root addChild: gameElement.
	space root extent: game gridExtent * (skin cellSize + (2 * skin cellMarginSize)).
	space show
]

{ #category : #adding }
GameElement >> addTileElementFor: aTile [

	| tileElement |
	tileElement := GCTileElement new
		text: aTile content asRopedText;
		yourself.
	tilesContainer addChild: tileElement.
	
	tileElement transformDo: [ :t |
		t translateBy: (self tilePositionFor: aTile) ].
	
	elementByTile
		at: aTile
		put: tileElement.
		
	^ tileElement
]

{ #category : #adding }
GameElement >> game [

	^ game
]

{ #category : #adding }
GameElement >> game: aGame [

	game ifNotNil: [ self notYetImplemented ].
	game := aGame.

	elementByTile := Dictionary new.

	slotsContainer layout: BlGridLayout vertical.
	slotsContainer layout rowCount: game gridExtent y.
	slotElementMatrix := Array2D
		rows: game gridExtent y
		columns: game gridExtent x
		tabulate: [ :row :column | GCElement new ].
	slotElementMatrix withIndicesDo: [:each :row :column |
		slotsContainer
			addChild: each
			as: ('{1}@{2}' format: {column.row}) ].
	"If slots resize, then tiles must be repositioned."
	slotElementMatrix anyOne
		when: BlElementExtentChangedEvent
		do: [ :event | self refreshOnSlotsPixelResize ].

	game tiles do: [ :each |
		self addTileElementFor: each ].
	self refreshScoreInTitle.
	
	self subscribeToGameAnnouncements.
]

{ #category : #adding }
GameElement >> initialize [

	super initialize.

	"The tile container is an overlay on top of the slots."
	self
		addChild: (slotsContainer := GCElement new) as: #slotContainer;
		addChild: (tilesContainer := GCElement new) as: #tileContainer.

	"Key bindings need to be registered on the parent"
	isSlideEnabled := false.
	self
		when: BlElementAddedToParentEvent
		do: [ :anEvent |
			isSlideEnabled := true.
			self
				registerKeyBindings ].

]

{ #category : #adding }
GameElement >> refreshOnDeletedTile: aGCDeletedTileAnnouncement [ 
	
	| tileElement |
	tileElement := elementByTile at: aGCDeletedTileAnnouncement tile.
	
	tileElement addAnimation:
		(BlOpacityAnimation new
			duration: 0.2 seconds;
			opacity: 0.0;
			onFinishedDo: [ tileElement removeFromParent ];
			yourself)
			
 
]

{ #category : #adding }
GameElement >> refreshOnFinished: ann [
	
	| containerElement label id |
	self unregisterEventHandlers.

	id := ann isSuccess
		ifTrue: [ #success ]
		ifFalse: [ #failed ].
		
	containerElement := GCElement new id: id; yourself.

	label :=
		BlTextElement new
			text: id asString capitalized asRopedText;
			yourself.

	self addChild: containerElement as: id.
	containerElement
		addChild: label as: #label;
		opacity: 0.0;
		addAnimation:
			(BlOpacityAnimation new
				duration: 0.2 seconds;
				opacity: 1.0;
				yourself).

]

{ #category : #adding }
GameElement >> refreshOnInsertedTile: aGCInsertedTileAnnouncement [ 
	
	| newElement |
	newElement := self addTileElementFor: aGCInsertedTileAnnouncement tile.
	
	newElement
		opacity: 0.0;
		addAnimation:
			(BlOpacityAnimation new
				duration: 0.2 seconds;
				opacity: 1.0;
				yourself)
]

{ #category : #adding }
GameElement >> refreshOnMovedTile: aGCMovedTileAnnouncement [ 
	
	| aTile |
	aTile := aGCMovedTileAnnouncement tile.
	(elementByTile at: aTile) transformDo: [ :t |
		t translateBy: (self tilePositionFor: aTile) ]
]

{ #category : #adding }
GameElement >> refreshOnSlideDone [

	self refreshScoreInTitle
]

{ #category : #adding }
GameElement >> refreshOnSlotsPixelResize [
	
	elementByTile keysAndValuesDo: [ :tile :tileElement |
		tileElement transformDo: [ :t | 
			t translateBy: (self tilePositionFor: tile) ]].
]

{ #category : #adding }
GameElement >> refreshOnUpgradedTile: aGCUpgradedTileAnnouncement [

	| aTile |
	aTile := aGCUpgradedTileAnnouncement tile.
	(elementByTile at: aTile) text: aTile content asRopedText
]

{ #category : #adding }
GameElement >> refreshScoreInTitle [
	
	self space ifNotNil: [ :s | s title: ('Score: ', game score asString) ]
]

{ #category : #adding }
GameElement >> registerKeyBindings [

	| selectorByKey |
	selectorByKey := {
		KeyboardKey up    -> #slideUp.
		KeyboardKey down  -> #slideDown.
		KeyboardKey left  -> #slideLeft.
		KeyboardKey right -> #slideRight.
	} asDictionary.

	keyBindingsEventHandler := BlEventHandler on: BlKeyUpEvent do: [ :evt |
		selectorByKey
			at: evt key
			ifPresent: [ :slideSelector |
				self
					slideIfEnabled: slideSelector
					andDisableDuring: 0.25 seconds ] ].

	self parent addEventHandler: keyBindingsEventHandler.
]

{ #category : #adding }
GameElement >> registerToMouseWheel [

	mouseWheelEventHandler :=
		BlEventHandler
			on: BlMouseWheelEvent
			do: [ :evt |
				#(
					isScrollLeft 	slideLeft
					isScrollRight 	slideRight
					isScrollUp 		slideUp
					isScrollDown 	slideDown
				) pairsDo: [ :scrollSelector :slideSelector |
					(evt perform: scrollSelector) ifTrue: [
						"Quite a lot of wait, but else it is annoying on Mac"
						self
							slideIfEnabled: slideSelector
							andDisableDuring: 1 second ] ]
				].

	self parent addEventHandler: mouseWheelEventHandler.
]

{ #category : #adding }
GameElement >> slideIfEnabled: slideSelector andDisableDuring: aDuration [

	isSlideEnabled ifFalse: [ ^self ].

	"Disable slides during a period"
	isSlideEnabled := false.
	[	self space time wait: aDuration.
		isSlideEnabled := true ] fork.
	
	game perform: slideSelector
]

{ #category : #adding }
GameElement >> tilePositionFor: aTile [
	"Answer the local pixel position that corresponds to the tile position, which is a board position. Use the corresponding slot as a reference."

	^ (slotElementMatrix
		at: aTile position x
		at: aTile position y) position
]

{ #category : #adding }
GameElement >> unregisterEventHandlers [

	self parent
		removeEventHandler: keyBindingsEventHandler;
		removeEventHandler: mouseWheelEventHandler
]
