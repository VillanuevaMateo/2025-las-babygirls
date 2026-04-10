"
Uniquely identifies each player and knows their exact position (the exact square)
"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'name',
		'currentSquare'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
}

{ #category : 'instance creation' }
Player class >> named: aName [ 
	^ self new initializeNamed: aName
]

{ #category : 'accessing' }
Player >> currentSquare [
	^ currentSquare
]

{ #category : 'initialization' }
Player >> initializeNamed: aName [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].
	currentSquare := nil.
	name := aName.
]

{ #category : 'path commands' }
Player >> moveTo: aSquare [

	currentSquare := aSquare.
]

{ #category : 'accessing' }
Player >> name [
	^ name
]
