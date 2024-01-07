Class {
	#name : #GAME2048,
	#superclass : #Game2048Elements,
	#instVars : [
		'game',
		'slotsContainer',
		'slotElementMatrix',
		'skin',
		'elementByTile',
		'tilesContainer',
		'isSlideEnabled',
		'keyBindingsEventHandler'
	],
	#category : #'Project_2048_Game_UI'
}

{ #category : #opening }
GAME2048 class >> on: aGame skin: aSkin [

	^ self basicNew
		createGrid: aGame skin: aSkin;
		yourself
]

{ #category : #opening }
GAME2048 class >> openGame [

	| game gameElement space skin |
	game := Game2048 new.
	game gridSize: 4.
	skin := Game2048Skin new.
	gameElement := self on: game skin: skin.

	space := BlSpace new.
	space root addChild: gameElement.
	space
		extent: 600 @ 600;
		position: 550 @ 200;
		resizable: false;
		show
]

{ #category : #'initialize game grid' }
GAME2048 >> addTileValueFor: row and: col [

	| tileElement  actualValue|
	tileElement := GAME2048LabelElement new
	text: (game grid at: row at: col) value asRopedText;
	yourself.
		
	tilesContainer addChild: tileElement.
	
	tileElement transformDo: [ :t |
		t translateBy: ((slotElementMatrix
		at: col
		at: row ) position)
		 ].
	
		
		actualValue := (game grid at: row at: col) value.
		
		actualValue = 2 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color paleTan;
			applyTileInsertedSkinOn: tileElement] ifFalse: [ 
			actualValue = 4 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color lightYellow;
			applyTileInsertedSkinOn: tileElement] ifFalse:[
				actualValue = 8 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color lightOrange;
			applyTileInsertedSkinOn: tileElement] ifFalse:[ 
					actualValue = 16 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color orange;
			applyTileInsertedSkinOn: tileElement] ifFalse:[
						actualValue = 32 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color paleRed;
			applyTileInsertedSkinOn: tileElement] ifFalse:[ 
							actualValue = 64 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color lightRed darker;
			applyTileInsertedSkinOn: tileElement] ifFalse:[ 
								actualValue = 128 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color lightBlue;
			applyTileInsertedSkinOn: tileElement] ifFalse:[ 
									actualValue = 256 ifTrue:[ skin applyTileSkinOn: tileElement setColor: Color blue;
			applyTileInsertedSkinOn: tileElement] ifFalse:[ 
		                      skin applyTileSkinOn: tileElement setColor: Color lightGreen darker]]]] ]]]].
		
	
	^ tileElement
]

{ #category : #'initialize game grid' }
GAME2048 >> createGrid: theGame [

	game := theGame.
	
	slotsContainer layout: BlGridLayout vertical.
	slotsContainer layout rowCount: game gridSize.
	slotElementMatrix := Array2D
		rows: game gridSize
		columns: game gridSize
		tabulate: [ :row :column |
			self newSlotElementForRow: row column: column ].
	slotElementMatrix do: [:each |
		slotsContainer addChild: each ].
	
	1 to: game gridSize by: 1 do: [ :row |
		1 to: game gridSize by: 1 do: [ :col |
			(game grid at: row at: col) ifNotNil:[ 
			self addTileValueFor: row and: col]
        ]
    ].
	
		self refreshScoreInTitle.
]

{ #category : #'initialize game grid' }
GAME2048 >> createGrid: theGame skin: theSkin [

	self
		initialize;
		initializeWithSkin: theSkin;
		createGrid: theGame
]

{ #category : #'initialize game grid' }
GAME2048 >> initialize [

	super initialize.

	"The tile container is an overlay on top of the slots."
	slotsContainer := Game2048Elements new.
	tilesContainer := Game2048Elements new.
	self
		addChild: slotsContainer;
		addChild: tilesContainer.

	"Key bindings need to be registered on the parent"
	isSlideEnabled := false.
	self addEventHandler: (BlEventHandler
			 on: BlElementAddedToParentEvent
			 do: [ :anEvent |
				 isSlideEnabled := true.
				 self registerKeyBindings ])
]

{ #category : #'initialize game grid' }
GAME2048 >> initializeWithSkin: aSkin [

	skin := aSkin.
	skin applyGameSkinOn: self
]

{ #category : #'as yet unclassified' }
GAME2048 >> isGameLose: theGame [

	| label |
	
	theGame ifLose ifFalse: [ ^ self ].
	label := GAME2048LabelElement new.
	self addChild: label.
	skin applyGameFailedMessageSkinOn: label.
	self unregisterEventHandlers
]

{ #category : #'as yet unclassified' }
GAME2048 >> isGameWin: theGame [

	| label |
	
	theGame ifWin ifFalse: [ ^ self ].
	label := GAME2048LabelElement new.
	self addChild: label.
	skin applyGameSuccessMessageSkinOn: label.
	self unregisterEventHandlers
]

{ #category : #'as yet unclassified' }
GAME2048 >> newSlotElementForRow: row column: column [

	| newSlotElement |
	newSlotElement := self class new.
	newSlotElement id: ('{1}@{2}' format: {column.row}).

	skin applySlotSkinOn: newSlotElement.
	
	^ newSlotElement
]

{ #category : #'as yet unclassified' }
GAME2048 >> refreshAfterMovedTile [
	
	tilesContainer removeChildren.
	
	1 to: game gridSize by: 1 do: [ :row |
		1 to: game gridSize by: 1 do: [ :col |
			(game grid at: row at: col) ifNotNil:[	 
			self addTileValueFor: row and: col]
        ]
    ].
]

{ #category : #'as yet unclassified' }
GAME2048 >> refreshScoreInTitle [
	
	self space ifNotNil: [ :s | s title: ('Score: ', game score asString) ]
]

{ #category : #'as yet unclassified' }
GAME2048 >> registerKeyBindings [

	| selectorByKey |
	selectorByKey := {
		KeyboardKey up    -> #moveUp.
		KeyboardKey down  -> #moveDown.
		KeyboardKey left  -> #moveLeft.
		KeyboardKey right -> #moveRight.
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

{ #category : #'as yet unclassified' }
GAME2048 >> slideIfEnabled: slideSelector andDisableDuring: aDuration [

	isSlideEnabled ifFalse: [ ^self ].

	"Disable slides during a period"
	isSlideEnabled := false.
	[	self space time wait: aDuration.
		isSlideEnabled := true ] fork.
	
	game perform: slideSelector.
	
	game addTileAtRandom.
	
	game determineScore.
	
	self refreshAfterMovedTile.
	
	self refreshScoreInTitle.
	
	self isGameLose: game.
	
	self isGameWin: game.
	
]

{ #category : #'initialize game grid' }
GAME2048 >> slotsContainer [

	^ slotsContainer
]

{ #category : #'initialize game grid' }
GAME2048 >> tilesContainer [

	^ tilesContainer
]

{ #category : #'as yet unclassified' }
GAME2048 >> unregisterEventHandlers [

	self parent
		removeEventHandler: keyBindingsEventHandler
]
