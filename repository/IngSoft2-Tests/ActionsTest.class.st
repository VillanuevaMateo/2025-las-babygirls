Class {
	#name : 'ActionsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Game-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Game-Tests'
}

{ #category : 'tests - choosing actions' }
ActionsTest >> testSkipTurn [

	| game player action board turnOrder die |
	
	board := Board withAmountOfSquares: 5.
	player := Player named: 'Player 1'.
	
	board place: player at: 1.
	
	turnOrder := TurnOrder withPlayers: { player }.
	die := MockedDie withSides: 15. 
	
	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die
		requiredLaps: 2.
	action := RestAction new.

	player loseShield.
	
	
	game playTurnWith: action.

	self assert: player shields equals: 3.
	self assert: (board indexOfPlayer: player ) equals: 1.
]

{ #category : 'tests - choosing actions' }
ActionsTest >> testSkippedTurnIgnoresChosenAction [

	| game player action |

	action := RestAction new.
	player := Player named: 'P1'.
	player loseShield.
	player loseShield.
	player loseShield. "0 shields → 2 skips"

	game playTurnWith: action.

	self assert: player shields equals: 0.
	self assert: player skippedTurns equals: 1.
]
