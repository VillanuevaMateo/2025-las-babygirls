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

{ #category : 'tests - Players' }
SquaresTest >> testCannotRemovePlayerThatIsNotInSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	self should: [ aSquare removePlayer: aPlayer ] raise: Error.
]

{ #category : 'tests - properties' }
SquaresTest >> testCreateSquare [

	| aSquare |
	aSquare := Square new.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.


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
