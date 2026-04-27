"
Responsible for managing the game at a level of abstraction
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'turnOrder',
		'die',
		'winner',
		'requiredLaps'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialization' }
Game class >> withBoard: aBoard turnOrder: aTurnOrder die: aDie requiredLaps: aNumber [

	^self new initializeWithBoard: aBoard turnOrder: aTurnOrder die: aDie requiredLaps: aNumber.
]

{ #category : 'combats' }
Game >> applyCombatLossTo: aPlayer [

	aPlayer loseShield.
	board place: aPlayer at: 1.
]

{ #category : 'accessing' }
Game >> checkWinner: aPlayer [

	aPlayer laps >= requiredLaps ifTrue: [
		winner := aPlayer
	]
]

{ #category : 'combats' }
Game >> fightBetween: playerA and: playerB [

	| rollA rollB loser |

	rollA := die roll.
	rollB := die roll.

	rollA = rollB ifTrue: [ ^ self ].

	loser := rollA < rollB
		ifTrue: [ playerA ]
		ifFalse: [ playerB ].

	self applyCombatLossTo: loser.
]

{ #category : 'accessing' }
Game >> hasWinner [

	^ winner notNil
]

{ #category : 'initialization' }
Game >> initializeWithBoard: aBoard turnOrder: aTurnOrder die: aDie requiredLaps: laps [

	board := aBoard.
	turnOrder := aTurnOrder.
	die := aDie.
	requiredLaps := laps.
]

{ #category : 'accessing' }
Game >> isWinningPlayer: aPlayer [

	^ aPlayer laps >= requiredLaps
]

{ #category : 'moving players' }
Game >> movePlayer: aPlayer by: steps [
	board movePlayer: aPlayer by: steps.
]

{ #category : 'moving players' }
Game >> movePlayerByDieRoll: aPlayer [

	| steps |

	steps := die roll.

	self movePlayer: aPlayer by: steps.
]

{ #category : 'moving players' }
Game >> performMoveFor: aPlayer [

	| steps |

	steps := die roll.

	board movePlayer: aPlayer by: steps.

	self resolveLandingOf: aPlayer.
	self resolveCombatFor: aPlayer.
]

{ #category : 'play turn' }
Game >> playTurn [

	| currentPlayer |
	
	winner ifNotNil: [ ^ self ].

	currentPlayer := turnOrder next.

	currentPlayer hasTurnsToSkip ifTrue: [
		currentPlayer skipTurn.
		^ self
	].
	
	self performMoveFor: currentPlayer.

	self checkWinner: currentPlayer.
]

{ #category : 'play turn' }
Game >> playTurnFor: aPlayer using: aDie [

	self movePlayer: aPlayer by: aDie roll.
]

{ #category : 'play turn' }
Game >> playTurnWith: anAction [

	| currentPlayer |
	
	self hasWinner ifTrue: [ ^ self ].


	currentPlayer := turnOrder next.

	currentPlayer hasTurnsToSkip ifTrue: [
		currentPlayer skipTurn.
		^ self
	].

	anAction executeFor: currentPlayer in: self.

	self checkWinner: currentPlayer.
]

{ #category : 'accessing' }
Game >> players [
	^ turnOrder players
]

{ #category : 'combats' }
Game >> resolveCombatFor: aPlayer [

	| playersHere rolls minRoll losers |

	playersHere := aPlayer currentSquare players.

	playersHere size <= 1 ifTrue: [ ^ self ].

	rolls := playersHere collect: [ :each |
		each -> die roll
	].

	minRoll := (rolls collect: [ :assoc | assoc value ]) min.

	losers := rolls select: [ :assoc |
		assoc value = minRoll
	].

	losers do: [ :assoc |
		self applyCombatLossTo: assoc key
	].
]

{ #category : 'moving players' }
Game >> resolveLandingOf: aPlayer [
	aPlayer currentSquare applyEffectTo: aPlayer in: self
]

{ #category : 'moving players' }
Game >> sendToStart: aPlayer [
	board place: aPlayer at: 1
]

{ #category : 'calculate parsecs' }
Game >> stepsForParsecs: parsecs [
	^ board stepsForParsecs: parsecs
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
