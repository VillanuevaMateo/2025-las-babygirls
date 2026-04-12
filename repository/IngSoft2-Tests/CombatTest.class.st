Class {
	#name : 'CombatTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Game-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Game-Tests'
}

{ #category : 'tests - combat' }
CombatTest >> testCombatSendsLowestRollToStart [

	| game board p1 p2 p3 turnOrder die |

	die := MockedSequencedDie withSequence: #(5 2 6). "p2 pierde"

	board := Board withSquares: {
		Square new.
		Square new.
		Square new
	}.

	p1 := Player named: 'P1'.
	p2 := Player named: 'P2'.
	p3 := Player named: 'P3'.

	turnOrder := TurnOrder withPlayers: { p1. p2. p3 }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: p1 at: 2.
	board place: p2 at: 2.
	board place: p3 at: 2.

	game resolveCombatFor: p1.

	self assert: p2 shields equals: 2.
	self assert: (board indexOfPlayer: p2) equals: 1.

	self assert: p1 shields equals: 3.
	self assert: p3 shields equals: 3.
]

{ #category : 'tests - combat' }
CombatTest >> testCombatTieAllLowestLose [

	| game board p1 p2 p3 turnOrder die |

	die := MockedSequencedDie withSequence: #(2 2 5). "p1 y p2 pierden"

	board := Board withSquares: {
		Square new.
		Square new
	}.

	p1 := Player named: 'P1'.
	p2 := Player named: 'P2'.
	p3 := Player named: 'P3'.

	turnOrder := TurnOrder withPlayers: { p1. p2. p3 }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: p1 at: 1.
	board place: p2 at: 1.
	board place: p3 at: 1.

	game resolveCombatFor: p1.

	self assert: p1 shields equals: 2.
	self assert: p2 shields equals: 2.
	self assert: p3 shields equals: 3.

	self assert: (board indexOfPlayer: p1) equals: 1.
	self assert: (board indexOfPlayer: p2) equals: 1.
]

{ #category : 'tests - combat' }
CombatTest >> testPlayersFightWhenLandingOnSameSquare [

	| game board player1 player2 turnOrder die |

	die := MockedSequencedDie withSequence: #(2 5). "player1 pierde"

	board := Board withSquares: {
		Square new.
		Square new.
		Square new
	}.

	player1 := Player named: 'P1'.
	player2 := Player named: 'P2'.

	turnOrder := TurnOrder withPlayers: { player1. player2 }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player1 at: 1.
	board place: player2 at: 3.

	self assert: player1 shields equals: 3.
	game movePlayer: player1 forward: 2. "cae con player2" "pierde player2"
	self assert: player2 shields equals: 2.
	self assert: (board indexOfPlayer: player2 ) equals: 1.
	self assert: (board indexOfPlayer: player1 ) equals: 3.
]
