"
He knows which players are in this box
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'players'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
}

{ #category : 'adding' }
Square >> addPlayer: aPlayer [

	players add: aPlayer.
]

{ #category : 'getter' }
Square >> amountOfPlayersInSquare [

	^ players size
]

{ #category : 'behavior' }
Square >> applyEffectTo: aPlayer in: aBoard [
	^nil.
]

{ #category : 'getter' }
Square >> hasPlayer: aPlayer [

	^ players includes: aPlayer
]

{ #category : 'initialization' }
Square >> initialize [

	super initialize.
	
	players := OrderedCollection new.
]

{ #category : 'getter' }
Square >> players [
	^ players copy
]

{ #category : 'removing' }
Square >> removePlayer: aPlayer [

	(players includes: aPlayer)
		ifFalse: [ self error: 'Player not in square' ].
		

	players remove: aPlayer.
]
