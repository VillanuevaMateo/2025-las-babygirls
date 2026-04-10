Class {
	#name : 'SquaresTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Board-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Board-Tests'
}

{ #category : 'tests - playerAmount' }
SquaresTest >> testAddMultiplePlayersToSquare [

	| aSquare |
	aSquare := Square new.
	aSquare increasingPlayerAmount.
	aSquare increasingPlayerAmount.
	
	self assert: aSquare amountOfPlayersInSquare equals: 2.


]

{ #category : 'tests - listOfPlayers' }
SquaresTest >> testAddPlayerToSquareList [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	aSquare addPlayer: aPlayer.
	
	self assert: aSquare amountOfPlayersInSquare equals: 1.
	self assert: (aSquare hasPlayer: aPlayer).
]

{ #category : 'tests - playerAmount' }
SquaresTest >> testCannotReducePlayersAmountWhenSquareIsEmpty [

	| aSquare |
	
	aSquare := Square new.
	
	self should: [ aSquare reducePlayerAmount ] raise: Error.
]

{ #category : 'tests - listOfPlayers' }
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

{ #category : 'tests - playerAmount' }
SquaresTest >> testEncreasePlayersAmount [

	| aSquare |
	aSquare := Square new.
	aSquare increasingPlayerAmount.
	
	self assert: aSquare amountOfPlayersInSquare equals: 1.


]

{ #category : 'tests - playerAmount' }
SquaresTest >> testReducePlayersAmount [

	| aSquare |
	aSquare := Square new.
	aSquare increasingPlayerAmount.
	
	self assert: aSquare amountOfPlayersInSquare equals: 1.
	
	aSquare reducePlayerAmount.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.


]

{ #category : 'tests - listOfPlayers' }
SquaresTest >> testRemovePlayerFromSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	aSquare addPlayer: aPlayer.
	aSquare removePlayer: aPlayer.
	
	self assert: aSquare amountOfPlayersInSquare equals: 0.
	self deny: (aSquare hasPlayer: aPlayer).
]
