"
He knows which players are in this box
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'playersInSquare',
		'playersList'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
}

{ #category : 'adding' }
Square >> addPlayer: aPlayer [

	self increasingPlayerAmount.
	playersList add: aPlayer.
]

{ #category : 'getter' }
Square >> amountOfPlayersInSquare [
	
	^playersInSquare.
]

{ #category : 'getter' }
Square >> hasPlayer: aPlayer [

	^ playersList includes: aPlayer
]

{ #category : 'adding' }
Square >> increasingPlayerAmount [
	playersInSquare := playersInSquare +1.
]

{ #category : 'removing' }
Square >> reducePlayerAmount [

	playersInSquare = 0 ifTrue: [ self error: 'Cannot remove player from empty square' ].
	playersInSquare := playersInSquare - 1.
]

{ #category : 'removing' }
Square >> removePlayer: aPlayer [

	(playersList includes: aPlayer)
		ifFalse: [ self error: 'Player not in square' ].
		
	self reducePlayerAmount.

	playersList remove: aPlayer.
]
