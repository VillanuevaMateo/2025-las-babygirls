Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Game-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Game-Tests'
}

{ #category : 'tests - game ending' }
GameTest >> testGameDoesNotPlayTurnWhenFinished [

	| board player game turnOrder die |
	
	board := Board withAmountOfSquares: 5.
	player := Player named: 'Player 1'.
	
	board place: player at: 3.
	
	turnOrder := TurnOrder withPlayers: { player }.
	die := MockedDie withSides: 3.
	
	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die
		requiredLaps: 1.
	
	"Primer turno: gana"
	game playTurn.
	
	self assert: game hasWinner.
	
	"Intento jugar de nuevo"
	game playTurn.
	
	self assert: player currentSquare equals: (board squareAt: 1).
]

{ #category : 'tests - game ending' }
GameTest >> testGameHasWinnerWhenPlayerReachesLastSquare [

	| board player game turnOrder die |
	
	board := Board withAmountOfSquares: 5.
	player := Player named: 'Player 1'.
	
	board place: player at: 1.
	
	turnOrder := TurnOrder withPlayers: { player }.
	die := MockedDie withSides: 5. 
	
	game := Game 
		withBoard: board 
		turnOrder: turnOrder 
		die: die
		requiredLaps: 1.
	
	game playTurn.
	
	self assert: game hasWinner.
	self assert: game winner equals: player.
]

{ #category : 'tests - moving players' }
GameTest >> testGamePlayTurnMovesNextPlayer [

	| aBoard player1 player2 turnOrder aDie aGame |
	
	aBoard := Board withSquares: {
		Square new.
		Square new.
		Square new.
		Square new.
		Square new.
		Square new.
		Square new.
		Square new.
		Square new.
		Square new
	}.
	player1 := Player named: 'Player 1'.
	player2 := Player named: 'Player 2'.
	
	aBoard place: player1 at: 1.
	aBoard place: player2 at: 1.
	
	turnOrder := TurnOrder withPlayers: { player1 . player2 }.
	aDie := MockedSequencedDie withSequence: #(3 5).
	
	aGame := Game 
		withBoard: aBoard 
		turnOrder: turnOrder 
		die: aDie
		requiredLaps: 1.
	
	aGame playTurn.
	
	self assert: player1 currentSquare equals: (aBoard squareAt: 4).
	
	aGame playTurn.
	
	self assert: player2 currentSquare equals: (aBoard squareAt: 6).
	
]

{ #category : 'tests - moving players' }
GameTest >> testPlayerCompletesALapWhenPassingLastSquare [

	| board player |
	
	board := Board withAmountOfSquares: 5.
	player := Player named: 'Player 1'.
	
	board place: player at: 4.
	board movePlayer: player by: 3.
	
	self assert: player currentSquare equals: (board squareAt: 2).
	self assert: player laps equals: 1.
]

{ #category : 'tests - game ending' }
GameTest >> testPlayerWinsAfterCompletingRequiredLaps [

	| board player game turnOrder die |
	
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
	
	game playTurn.
	
	self assert: game hasWinner.
	self assert: game winner equals: player.
]
