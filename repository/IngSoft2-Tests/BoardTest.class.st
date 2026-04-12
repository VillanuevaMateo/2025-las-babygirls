Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Board-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Board-Tests'
}

{ #category : 'tests - properties' }
BoardTest >> testBoardKeepsSquaresOrder [

	| aBoard firstSquare secondSquare |
	
	aBoard := Board withAmountOfSquares: 2.
	
	firstSquare := aBoard squareAt: 1.
	secondSquare := aBoard squareAt: 2.
	
	self deny: firstSquare equals: secondSquare.
]

{ #category : 'tests - properties' }
BoardTest >> testBoardKnowsItsSize [

	| aBoard |
	
	aBoard := Board withAmountOfSquares: 7.
	
	self assert: (aBoard size) equals: 7.
]

{ #category : 'tests - initialization' }
BoardTest >> testCreateBoardWithSquares [

	| aBoard |
	
	aBoard := Board withAmountOfSquares: 5.
	
	self assert: (aBoard squareAt: 1) notNil.
	self assert: (aBoard squareAt: 5) notNil.
]

{ #category : 'tests - moving players' }
BoardTest >> testMovePlayerForward [

	| aBoard aPlayer |
	
	aBoard := Board withAmountOfSquares: 5 .
	aPlayer := Player named: 'Player 1'.
	
	aBoard place: aPlayer at: 1.
	aBoard move: aPlayer forward: 3.
	
	self assert: aPlayer currentSquare equals: (aBoard squareAt: 4).
]

{ #category : 'tests - moving players' }
BoardTest >> testMovePlayerUsingDie [

	| aBoard aPlayer aDie |
	
	aBoard := Board withAmountOfSquares: 5 .
	aPlayer := Player named: 'Player 1'.
	aDie := MockedDie withSides: 3.
	
	aBoard place: aPlayer at: 1.
	aBoard move: aPlayer forward: (aDie roll).
	
	self assert: aPlayer currentSquare equals: (aBoard squareAt: 4).
]

{ #category : 'tests - player position' }
BoardTest >> testPlacingPlayerRemovesItFromPreviousSquare [

	| aBoard aPlayer firstSquare secondSquare |
	
	aBoard := Board withAmountOfSquares: 5.
	aPlayer := Player named: 'Player 1'.
	
	aBoard place: aPlayer at: 1.
	firstSquare := aBoard squareAt: 1.
	
	aBoard place: aPlayer at: 2.
	secondSquare := aBoard squareAt: 2.
	
	self deny: (firstSquare hasPlayer: aPlayer).
	self assert: (secondSquare hasPlayer: aPlayer).
	self assert: aPlayer currentSquare equals: secondSquare.
]

{ #category : 'tests - player position' }
BoardTest >> testPlacingPlayerUpdatesBothSides [

	| aBoard aPlayer aSquare |
	
	aBoard := Board withAmountOfSquares: 5.
	aPlayer := Player named: 'Player 1'.
	
	aBoard place: aPlayer at: 1.
	aSquare := aBoard squareAt: 1.
	
	self assert: aPlayer currentSquare equals: aSquare.
	self assert: (aSquare hasPlayer: aPlayer).
]

{ #category : 'tests - moving players' }
BoardTest >> testPlayTurnMovesPlayerUsingDie [

	| aBoard aPlayer aDie |
	
	aBoard := Board withAmountOfSquares: 5 .

	aPlayer := Player named: 'Player 1'.
	aDie := MockedDie withSides: 3. "roll = 3"
	
	aBoard place: aPlayer at: 1.
	
	aBoard playTurnFor: aPlayer using: aDie.
	
	self assert: aPlayer currentSquare equals: (aBoard squareAt: 4).
]

{ #category : 'tests - moving players' }
BoardTest >> testTurnOrderReturnsNextPlayer [

	| turnOrder player1 player2 |
	
	player1 := Player named: 'Player 1'.
	player2 := Player named: 'Player 2'.
	
	turnOrder := TurnOrder withPlayers: { player1 . player2 }.
	
	self assert: turnOrder next equals: player1.
	self assert: turnOrder next equals: player2.
	self assert: turnOrder next equals: player1.
]
