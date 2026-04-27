"
Know who is next to play
"
Class {
	#name : 'TurnOrder',
	#superclass : 'Object',
	#instVars : [
		'players',
		'currentIndex'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
}

{ #category : 'initialization' }
TurnOrder class >> withPlayers: aCollection [ 
	^self new initializeWithPlayers: aCollection

]

{ #category : 'initialization' }
TurnOrder >> initializeWithPlayers: aCollection [

	players := aCollection asOrderedCollection.
	currentIndex := 0.
]

{ #category : 'behavior' }
TurnOrder >> next [

	currentIndex := currentIndex + 1.
	
	currentIndex > players size ifTrue: [
		currentIndex := 1
	].
	
	^ players at: currentIndex
]

{ #category : 'accessing' }
TurnOrder >> players [ 
	^players 
]
