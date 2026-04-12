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
	
	aSquare addPlayer: aPlayer.
	
	self assert: aSquare amountOfPlayersInSquare equals: 1.
	self assert: (aSquare hasPlayer: aPlayer).
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

{ #category : 'tests - special squares' }
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

	board move: player forward: 1.

	self assert: player currentSquare equals: wormHoleExit.
]

{ #category : 'tests - Players' }
SquaresTest >> testRemovePlayerFromSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	aSquare addPlayer: aPlayer.
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
