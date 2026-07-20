Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Cards-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Cards-Tests'
}

{ #category : 'tests' }
CardTest >> testPlayerCanPlayACard [

	| game board player turnOrder die card |

	die := MockedDie withSides: 2.
	board := Board withAmountOfSquares: 5.

	player := Player named: 'Player1'.
	card := player cards first.

	turnOrder := TurnOrder withPlayers: { player }.

	game := Game
		withBoard: board
		turnOrder: turnOrder
		die: die
		requiredLaps: 5.

	game player: player playsCard: card.

	self assert: player cards size equals: 1.
	self deny: (player cards includes: card).
]

{ #category : 'tests' }
CardTest >> testPlayerCanPlayInstantCardOutsideItsTurn [

	| game board player1 player2 turnOrder die card |

	die := MockedDie withSides: 2.
	board := Board withAmountOfSquares: 5.

	player1 := Player named: 'Player1'.
	player2 := Player named: 'Player2'.

	card := player2 cards first.

	turnOrder := TurnOrder withPlayers: { player1. player2 }.

	game := Game
		withBoard: board
		turnOrder: turnOrder
		die: die
		requiredLaps: 5.

	game player: player2 playsCard: card.

	self assert: player2 cards size equals: 1.
	self deny: (player2 cards includes: card).
]

{ #category : 'tests' }
CardTest >> testPlayerCannotPlayPermanentCardOutsideItsTurn [

	| game board player1 player2 turnOrder die card |

	die := MockedDie withSides: 2.
	board := Board withAmountOfSquares: 5.

	player1 := Player named: 'Player1'.
	player2 := Player named: 'Player2'.

	card := PermanentCard new.
	player2 cards
		removeAll;
		add: card.

	turnOrder := TurnOrder withPlayers: { player1. player2 }.

	game := Game
		withBoard: board
		turnOrder: turnOrder
		die: die
		requiredLaps: 5.

	self
		should: [ game player: player2 playsCard: card ]
		raise: Error.

	self assert: player2 cards size equals: 1.
]
