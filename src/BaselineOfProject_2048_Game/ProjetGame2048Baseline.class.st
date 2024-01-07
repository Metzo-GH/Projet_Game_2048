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
            baseline: 'Project_2048_Game'
            with: [ spec repository: 'https://github.com/Metzo-GH/Projet_Game_2048.git' ].
        spec
            baseline: 'Project_2048_Game_Test'
            with: [ spec repository: 'https://github.com/Metzo-GH/Projet_Game_2048.git' ].
        spec
            baseline: 'Project_2048_Game_UI'
            with: [ spec repository: 'https://github.com/Metzo-GH/Projet_Game_2048.git' ].
    ]
]
