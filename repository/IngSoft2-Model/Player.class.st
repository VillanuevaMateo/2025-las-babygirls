"
Uniquely identifies each player and knows their exact position (the exact square)
"
Class {
	#name : 'Player',
	#superclass : 'Object',
	#instVars : [
		'name',
		'currentSquare',
		'laps',
		'shields',
		'skippedTurns',
		'cards'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
Player class >> named: aName [ 
	^ self new initializeNamed: aName
]

{ #category : 'accessing' }
Player >> cards [

	^ cards
]

{ #category : 'change position' }
Player >> completeLap [
	laps := laps + 1.
]

{ #category : 'accessing' }
Player >> currentSquare [
	^ currentSquare
]

{ #category : 'accessing' }
Player >> hasTurnsToSkip [
	^ skippedTurns > 0
]

{ #category : 'initialization' }
Player >> initializeNamed: aName [

	aName isEmpty ifTrue: [ self error: 'Name cannot be empty' ].
	currentSquare := nil.
	name := aName.
	cards := OrderedCollection new.
	2 timesRepeat: [ cards add: Card random ].
	laps := 0.
	shields := 3.
	skippedTurns := 0.
]

{ #category : 'accessing' }
Player >> laps [
	^ laps
]

{ #category : 'shields' }
Player >> loseShield [

	shields := shields - 1.
	shields = 0 ifTrue: [
		skippedTurns := 2
	].
]

{ #category : 'change position' }
Player >> moveTo: aSquare [

	currentSquare := aSquare.
]

{ #category : 'accessing' }
Player >> name [
	^ name
]

{ #category : 'cards' }
Player >> playCard: aCard [

	(cards includes: aCard)
		ifFalse: [ self error: 'Player does not own this card' ].

	cards remove: aCard.
]

{ #category : 'rest' }
Player >> rest [
	shields := 3.
]

{ #category : 'accessing' }
Player >> shields [
	^ shields
]

{ #category : 'rest' }
Player >> skipTurn [
	skippedTurns := skippedTurns - 1.
	shields :=3.
]

{ #category : 'accessing' }
Player >> skippedTurns [
	^ skippedTurns
]

{ #category : 'change position' }
Player >> undoLap [
	
	laps := laps - 1
]
