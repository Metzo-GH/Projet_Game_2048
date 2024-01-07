Class {
	#name : #ProjetGame2048Baseline,
	#superclass : #BaselineOf,
	#category : #'BaselineOfProject_2048_Game'
}

{ #category : #baselines }
ProjetGame2048Baseline >> baseline: spec [
    <baseline>

    spec for: #common do: [
        spec
            repository: 'github://Metzo-GH/Projet_Game_2048:master/src';
            package: 'Project_2048_Game';
            package: 'Project_2048_Game_Test' with: [ spec requires: #('Project_2048_Game') ];
            package: 'Project_2048_Game_UI' with: [ spec requires: #('Project_2048_Game') ].
    ].
]
