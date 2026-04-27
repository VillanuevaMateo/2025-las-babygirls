Class {
	#name : 'SquaresTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Board-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Board-Tests'
}

{ #category : 'tests - Players' }
SquaresTest >> testAddPlayerToSquareList [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.
	self deny: (aSquare hasPlayer: aPlayer).
	
	aSquare addPlayer: aPlayer.
	
	self assert: aSquare amountOfPlayersInSquare equals: 1.
	self assert: (aSquare hasPlayer: aPlayer).
]

{ #category : 'tests - special squares - atomicBomb' }
SquaresTest >> testAtomicBombDoesNotAffectLaps [

	| game board player turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		Square new.
		AtomicBombSquare new.
		Square new
	}.

	player := Player named: 'P1'.
	player completeLap.
	player completeLap.
	player completeLap.

	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 2.

	game resolveLandingOf: player.

	self assert: player laps equals: 3.
]

{ #category : 'tests - special squares - atomicBomb' }
SquaresTest >> testAtomicBombSendsAllPlayersLoseShield [

	| game board player1 player2 player3 turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		Square new.
		AtomicBombSquare new.
		Square new.
		Square new.
		Square new
	}.

	player1 := Player named: 'P1'.
	player2 := Player named: 'P2'.
	player3 := Player named: 'P3'.

	turnOrder := TurnOrder withPlayers: { player1. player2. player3 }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player1 at: 2. "cae en bomba"
	board place: player2 at: 3.
	board place: player3 at: 5.

	self assert: (player1 shields) equals: 3.
	self assert: (player2 shields) equals: 3.
	self assert: (player3 shields) equals: 3.
	game resolveLandingOf: player1.

	self assert: (player1 shields) equals: 2.
	self assert: (player2 shields) equals: 2.
	self assert: (player3 shields) equals: 2.
]

{ #category : 'tests - special squares - atomicBomb' }
SquaresTest >> testAtomicBombSendsAllPlayersToStart [

	| game board player1 player2 player3 turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		Square new.
		AtomicBombSquare new.
		Square new.
		Square new.
		Square new
	}.

	player1 := Player named: 'P1'.
	player2 := Player named: 'P2'.
	player3 := Player named: 'P3'.

	turnOrder := TurnOrder withPlayers: { player1. player2. player3 }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player1 at: 2. "cae en bomba"
	board place: player2 at: 3.
	board place: player3 at: 5.

	game resolveLandingOf: player1.

	self assert: (board indexOfPlayer: player1) equals: 1.
	self assert: (board indexOfPlayer: player2) equals: 1.
	self assert: (board indexOfPlayer: player3) equals: 1.
]

{ #category : 'tests - special squares - blackHole' }
SquaresTest >> testBlackHoleMovesPlayerBackwardsFourSquares [

	| game board player turnOrder die |
	
	die:= MockedDie withSides: 2.
	board := Board withSquares: {
		Square new.
		Square new.
		Square new.
		Square new.
		BlackHoleSquare new.
		Square new
	}.

	player := Player named: 'Player1'.
	turnOrder := TurnOrder withPlayers: { player }.

	game := Game withBoard: board turnOrder: turnOrder die: die requiredLaps: 5.

	board place: player at: 5.

	game resolveLandingOf: player.

	self assert: (board indexOfPlayer: player) equals: 1.
]

{ #category : 'tests - special squares - blackHole' }
SquaresTest >> testBlackHoleWrapsAroundBoard [

	| game board player turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		BlackHoleSquare new.
		Square new.
		Square new.
		Square new
	}.

	player := Player named: 'Player1'.
	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 1.

	game resolveLandingOf: player.

	self assert: (board indexOfPlayer: player) equals: 1.
]

{ #category : 'tests - squares creation' }
SquaresTest >> testBoardGeneratesSquaresWithApproximateDistribution [

	| board squares total atomicBombCount ratio aDistribution |
	aDistribution := SquareDistribution new.
	total := 1000.

	board := Board withAmountOfSquares: total using: aDistribution.
	squares := board squares.

	atomicBombCount := squares count: [ :each |
		                   each isKindOf: AtomicBombSquare ].


	ratio := atomicBombCount / total.

	self assert: (ratio between: 0.005 and: 0.04)
]

{ #category : 'tests - squares creation' }
SquaresTest >> testBoardHasExactlyTwoWormHoles [

	| board wormHoles |

	board := Board withAmountOfSquares: 100 using: SquareDistribution new.

	wormHoles := board squares select: [ :each |
		each isKindOf: WormHoleSquare
	].

	self assert: wormHoles size equals: 2.


]

{ #category : 'tests - Players' }
SquaresTest >> testCannotRemovePlayerThatIsNotInSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	self should: [ aSquare removePlayer: aPlayer ] raise: Error.
]

{ #category : 'tests - squares creation' }
SquaresTest >> testCreateSquare [

	| aSquare |
	aSquare := Square new.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.


]

{ #category : 'tests - special squares - hyperJump' }
SquaresTest >> testHyperJumpConsumesValuesInOrder [

	| game board player turnOrder die hyperJump |

	die := MockedDie withSides: 2.

	hyperJump := HyperJumpSquare withParsecValues: #(6 4).

	board := Board 
		withSquares: { Square new. hyperJump. Square new. Square new }.

	player := Player named: 'P1'.

	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 2.

	game resolveLandingOf: player. "usa 6 → 3 casilleros"
	self assert: (board indexOfPlayer: player) equals: 1.

	board place: player at: 2.
	game resolveLandingOf: player. "usa 4 → 2 casilleros"
	self assert: (board indexOfPlayer: player) equals: 4.
]

{ #category : 'tests - special squares - hyperJump' }
SquaresTest >> testHyperJumpMovesPlayerUsingParsecs [

	| game board player turnOrder die hyperJump |

	die := MockedDie withSides: 2.

	hyperJump := HyperJumpSquare withParsecValues: #(8 4 2).

	board := Board 
		withSquares: {
			Square new.
			hyperJump.
			Square new.
			Square new.
			Square new
		}.

	player := Player named: 'P1'.

	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 2.

	game resolveLandingOf: player.

	"8 parsecs = 4 casilleros"
	self assert: (board indexOfPlayer: player) equals: 1.
]

{ #category : 'tests -special squares - hyperSpaceJump' }
SquaresTest >> testHyperSpaceJumpMovesPlayerForwardFourSquares [

	| game board player turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		Square new.
		HyperSpaceJumpSquare new.
		Square new.
		Square new.
		Square new.
		Square new
	}.

	player := Player named: 'Player1'.
	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 2.

	game resolveLandingOf: player.

	self assert: (board indexOfPlayer: player) equals: 6.
]

{ #category : 'tests -special squares - hyperSpaceJump' }
SquaresTest >> testHyperSpaceJumpPlayerLosesShield [

	| game board player turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		Square new.
		HyperSpaceJumpSquare new.
		Square new.
		Square new.
		Square new.
		Square new
	}.

	player := Player named: 'Player1'.
	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 2.

	game resolveLandingOf: player.

	self assert: (player shields ) equals: 2.
]

{ #category : 'tests -special squares - hyperSpaceJump' }
SquaresTest >> testHyperSpaceJumpWrapsAroundBoard [

	| game board player turnOrder die |

	die := MockedDie withSides: 2.

	board := Board withSquares: {
		Square new.
		Square new.
		Square new.
		HyperSpaceJumpSquare new.
		Square new
	}.

	player := Player named: 'Player1'.
	turnOrder := TurnOrder withPlayers: { player }.

	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die 
		requiredLaps: 5.

	board place: player at: 4.

	game resolveLandingOf: player.

	self assert: (board indexOfPlayer: player) equals: 3.
]

{ #category : 'tests -special squares - moonWalk' }
SquaresTest >> testMoonWalkMovesAllOtherPlayersBackwards [

	| game board player1 player2 player3 moonWalk turnOrder die|

	moonWalk := MoonWalkSquare withSteps: 3.
	die := MockedDie withSides: 2.
	board := Board withSquares: {
		Square new.
		Square new.
		moonWalk.
		Square new.
		Square new
	}.

	player1 := Player named: 'P1'.
	player2 := Player named: 'P2'.
	player3 := Player named: 'P3'.

	turnOrder := TurnOrder withPlayers: { player1. player2. player3 }.

	game := Game withBoard: board turnOrder: turnOrder die: die requiredLaps: 5.

	board place: player1 at: 1.
	board place: player2 at: 3.
	board place: player3 at: 4.

	game playTurn.

	self assert: (board indexOfPlayer: player1) equals: 3.
	self assert: (board indexOfPlayer: player2) equals: 5.
	self assert: (player2 laps) equals: -1.
	self assert: (board indexOfPlayer: player3) equals: 1.
]

{ #category : 'tests -special squares - wormHole' }
SquaresTest >> testPlayerEntersWormHoleAndExitsAtPairedSquare [

	| board player wormHoleEntry wormHoleExit |

	wormHoleEntry := WormHoleSquare new.
	wormHoleExit := WormHoleSquare new.
	
	wormHoleEntry pairWith: wormHoleExit.

	board := Board withSquares: { 
		Square new. 
		wormHoleEntry. 
		Square new. 
		wormHoleExit 
	}.

	player := Player named: 'Player1'.
	board place: player at: 1.

	board movePlayer: player by: 1.

	self assert: player currentSquare equals: wormHoleEntry.
]

{ #category : 'tests - Players' }
SquaresTest >> testRemovePlayerFromSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.
	self deny: (aSquare hasPlayer: aPlayer).
	
	aSquare addPlayer: aPlayer.
	
	self assert: aSquare amountOfPlayersInSquare equals: 1.
	self assert: (aSquare hasPlayer: aPlayer).
	
	aSquare removePlayer: aPlayer.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.
	self deny: (aSquare hasPlayer: aPlayer).
]

{ #category : 'tests - squares creation' }
SquaresTest >> testWormHolesArePaired [

	| board wormHoles a b |

	board := Board withAmountOfSquares: 100 using: SquareDistribution new.

	wormHoles := board squares select: [ :each |
		each isKindOf: WormHoleSquare
	].

	a := wormHoles first.
	b := wormHoles second.

	self assert: a pairedSquare equals: b.
	self assert: b pairedSquare equals: a.


]
