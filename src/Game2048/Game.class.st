Class {
	#name : #Game,
	#superclass : #Object,
	#category : #Game2048
}

{ #category : #'instance creation' }
Game class >> gridMenu [

	| menu |
	
	menu := ToMenu new.
	menu label: (ToLabel text: 'Grid').
	
	4 to: 12 by: 2 do: [ :index |
		| subMenu |
		subMenu := ToMenu new label:
			           (ToLabel new text: (String streamContents: [ :out |
					             out
						             print: index;
						             nextPut: $x;
						             print: index ])).
		1 to: 5 do: [ :i |
			| stream selector tmp |
			stream := String streamContents: [ :out |
				          out
					          nextPutAll: 'Level';
					          space;
					          print: i ].
			selector := String streamContents: [ :out |
				            out
					            nextPutAll: 'level';
					            print: index;
					            nextPutAll: 'Grid';
					            print: i ].
			tmp := TBoardElement class selectors select: [ :each |
				       each = selector ].
			subMenu addItem:
				((ToButtonMenuItem new labelText: stream) whenClickedDo: [
					 TBoardElement openWithModel: (TBoard perform: selector asSymbol) ]) ].
		menu addItem: subMenu ].

	^ menu
]

{ #category : #'instance creation' }
Game class >> open [
	"Les éléments à afficher dans la page d'accueil"
		| container space gridMenu |
	
	gridMenu	:= self gridMenu.
	
	"Le cadre de la page d'acceuil"
	container := BlElement new
						background: Color orange;
						layout: BlLinearLayout vertical;
						constraintsDo: [ :c | c horizontal matchParent.
													c vertical matchParent ].
	container addChildren: { 
									. }.
	
	space := BlSpace new.
	space root addChild: container.
	space extent: 650 @ 650.
	space show
	 								
									
								
]
