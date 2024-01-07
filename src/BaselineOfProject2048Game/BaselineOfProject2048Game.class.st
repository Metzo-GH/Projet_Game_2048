Class {
	#name : #BaselineOfProject2048Game,
	#superclass : #BaselineOf,
	#category : #BaselineOfProject2048Game
}

{ #category : #baselines }
BaselineOfProject2048Game >> baseline: spec [ 
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: #'Bloc'
			with: [ spec repository: 'github://pharo-graphics/bloc:dev-1.0/src' ].
		spec
			package: #'Project_2048_Game';
			package: #'Project_2048_Game_Test' with: [
				spec requires: #( #'Project_2048_Game' ).];
			package: #'Project_2048_Game_UI' with: [
				spec requires: #( #'Project_2048_Game' #'Bloc' ).].
	]

]