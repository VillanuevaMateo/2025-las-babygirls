"
Uniquely identifies each player and knows their exact position (the exact square)
"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'name',
		'currentSquare',
		'laps'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
}

{ #category : 'instance creation' }
Player class >> named: aName [ 
	^ self new initializeNamed: aName
]

{ #category : 'change position' }
Player >> completeLap [
	laps := laps + 1.
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
	laps := 0.
]

{ #category : 'accessing' }
Player >> laps [
	^ laps
]

{ #category : 'change position' }
Player >> moveTo: aSquare [

	currentSquare := aSquare.
]

{ #category : 'accessing' }
Player >> name [
	^ name
]
