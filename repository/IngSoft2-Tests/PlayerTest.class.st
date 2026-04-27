Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Board-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Board-Tests'
}

{ #category : 'tests - initialization' }
PlayerTest >> testCreatePlayerWithName [

	| aPlayer |
	
	aPlayer := Player named: 'Player 1'.
	
	self assert: aPlayer name equals: 'Player 1'.
]

{ #category : 'tests - properties' }
PlayerTest >> testPlayerKnowsItsCurrentSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	aPlayer moveTo: aSquare.
	
	self assert: aPlayer currentSquare equals: aSquare.
]

{ #category : 'tests - shields' }
PlayerTest >> testPlayerLosesTwoTurnsWhenShieldsReachZero [
	| player |

	player := Player named: 'P1'.

	player loseShield.
	player loseShield.
	player loseShield.

	self assert: player hasTurnsToSkip.
	self assert: player skippedTurns equals: 2.
]

{ #category : 'tests - initialization' }
PlayerTest >> testPlayerNameCannotBeEmpty [

	self should: [ Player named: '' ] raise: Error.
]

{ #category : 'tests - shields' }
PlayerTest >> testPlayerRestsInsteadOfMoving [

		| board player game turnOrder die |
	
	board := Board withAmountOfSquares: 5.
	player := Player named: 'Player 1'.
	
	board place: player at: 3.
	
	player loseShield.
	player loseShield.
	player loseShield.
	
	turnOrder := TurnOrder withPlayers: { player }.
	die := MockedDie withSides: 3.
	
	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die
		requiredLaps: 1.
		
	game playTurn.

	self assert: player shields equals: 3.
	self assert: (board indexOfPlayer: player) equals: 3.
]
