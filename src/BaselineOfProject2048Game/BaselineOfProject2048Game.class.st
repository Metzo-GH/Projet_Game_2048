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
            baseline: #'Project2048Game'
            with: [ spec repository: 'github.com/Metzo-GH/Projet_Game_2048:master/src' ].
        spec
            package: #'Project_2048_Game';
            package: #'Project_2048_Game_Test' with: [
                spec requires: #( #'Project_2048_Game' ) ];
            package: #'Project_2048_Game_UI' with: [
                spec requires: #( #'Project_2048_Game' ) ]
    ]

]
