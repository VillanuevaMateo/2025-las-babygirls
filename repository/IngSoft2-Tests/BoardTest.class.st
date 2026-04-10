Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Board-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Board-Tests'
}

{ #category : 'tests' }
BoardTest >> testBoardKeepsSquaresOrder [

	| aBoard firstSquare secondSquare |
	
	aBoard := Board withAmountOfSquares: 2.
	
	firstSquare := aBoard squareAt: 1.
	secondSquare := aBoard squareAt: 2.
	
	self deny: firstSquare equals: secondSquare.
]

{ #category : 'tests' }
BoardTest >> testBoardKnowsItsSize [

	| aBoard |
	
	aBoard := Board withAmountOfSquares: 7.
	
	self assert: (aBoard size) equals: 7.
]

{ #category : 'tests' }
BoardTest >> testCreateBoardWithSquares [

	| aBoard |
	
	aBoard := Board withAmountOfSquares: 5.
	
	self assert: (aBoard squareAt: 1) notNil.
	self assert: (aBoard squareAt: 5) notNil.
]

{ #category : 'tests - initialization' }
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

{ #category : 'tests - initialization' }
BoardTest >> testPlacingPlayerUpdatesBothSides [

	| aBoard aPlayer aSquare |
	
	aBoard := Board withAmountOfSquares: 5.
	aPlayer := Player named: 'Player 1'.
	
	aBoard place: aPlayer at: 1.
	aSquare := aBoard squareAt: 1.
	
	self assert: aPlayer currentSquare equals: aSquare.
	self assert: (aSquare hasPlayer: aPlayer).
]
