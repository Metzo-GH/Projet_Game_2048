Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Project_2048_Game'
}

{ #category : #accessing }
Tile class >> value: aValue [

	^ self new setValue: aValue
]

{ #category : #accessing }
Tile >> setValue: aValue [

	value := aValue
]

{ #category : #accessing }
Tile >> value [ 

	^ value
]

{ #category : #accessing }
Tile >> value: aValue [ 

	^ self setValue: aValue
]
