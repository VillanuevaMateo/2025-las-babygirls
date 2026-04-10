"
Responsible for managing the game at a level of abstraction
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'turnOrder',
		'die',
		'winner',
		'requiredLaps'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialization' }
Game class >> withBoard: aBoard turnOrder: aTurnOrder die: aDie requiredLaps: aNumber [

	^self new initializeWithBoard: aBoard turnOrder: aTurnOrder die: aDie requiredLaps: aNumber.
]

{ #category : 'events' }
Game >> hasWinner [

	^ winner notNil
]

{ #category : 'initialization' }
Game >> initializeWithBoard: aBoard turnOrder: aTurnOrder die: aDie requiredLaps: laps [

	board := aBoard.
	turnOrder := aTurnOrder.
	die := aDie.
	requiredLaps := laps.
]

{ #category : 'events' }
Game >> isWinningPlayer: aPlayer [

	^ aPlayer laps >= requiredLaps
]

{ #category : 'behavior' }
Game >> playTurn [

	| player |
	
	self hasWinner ifTrue: [ ^ self ].
	player := turnOrder next.
	
	board playTurnFor: player using: die.
	
	(self isWinningPlayer: player) ifTrue: [
		winner := player
	].
]

{ #category : 'events' }
Game >> winner [

	^ winner
]
