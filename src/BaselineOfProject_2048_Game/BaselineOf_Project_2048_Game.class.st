Class {
	#name : #'BaselineOf_Project_2048_Game',
	#superclass : #BaselineOf,
	#category : #'BaselineOfProject_2048_Game'
}

{ #category : #baselines }
BaselineOf_Project_2048_Game >> baseline: spec [
    <baseline>

    spec for: #common do: [
        spec repository: 'https://github.com/Metzo-GH/Projet_Game_2048/tree/master/src'.

        spec
            package: 'Project_2048_Game';
            package: 'Project_2048_Game_Test' with: [ spec requires: #('Project_2048_Game') ];
            package: 'Project_2048_Game_UI' with: [ spec requires: #('Project_2048_Game') ].
    ].

]
