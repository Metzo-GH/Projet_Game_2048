Class {
	#name : #'BaselineOfProjet_Game_2048',
	#superclass : #BaselineOf,
	#category : #'BaselineOfProjet_Game_2048'
}

{ #category : #baselines }
BaselineOfProjet_Game_2048 >> baseline: spec [
    <baseline>

    spec for: #common do: [ 
        spec
            baseline: #'Projet_Game_2048'
            with: [ spec repository: 'github.com/Metzo-GH/Projet_Game_2048:master/src' ].
        spec
            package: #'Project_2048_Game';
            package: #'Project_2048_Game_Test' with: [
                spec requires: #( #'Project_2048_Game' ) ];
            package: #'Project_2048_Game_UI' with: [
                spec requires: #( #'Project_2048_Game' ) ]
    ]

]
