"
model the game topology and manage the occupancy of the squares
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares',
		'totalParsecs'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
Board class >> withAmountOfSquares: numberOfSquares [

	^ self new initializeWithAmountOfSquares: numberOfSquares
]

{ #category : 'instance creation' }
Board class >> withAmountOfSquares: amount using: aDistribution [
	^ self withSquares: (aDistribution generateSquares: amount)
]

{ #category : 'instance creation' }
Board class >> withSquares: squares [

	^ self new initializeWithSquares: squares
]

{ #category : 'accessing' }
Board >> indexOf: aSquare [
	^ squares indexOf: aSquare
]

{ #category : 'accessing' }
Board >> indexOfPlayer: aPlayer [
	^ self indexOf: aPlayer currentSquare
]

{ #category : 'initialization' }
Board >> initializeWithAmountOfSquares: numberOfSquares [

	squares := OrderedCollection new.
	totalParsecs := squares size * 2.
	1 to: numberOfSquares do: [ :anIndex |
		squares add: Square new
	].
	
]

{ #category : 'initialization' }
Board >> initializeWithSquares: initialSquares [

	squares := initialSquares.
	totalParsecs := squares size * 2.
	
]

{ #category : 'behavior' }
Board >> movePlayer: aPlayer by: steps [

	| currentIndex size rawIndex laps newIndex |

	currentIndex := self indexOfPlayer: aPlayer.
	size := squares size.

	rawIndex := currentIndex + steps.

	laps := (rawIndex - 1) // size.

	laps > 0 ifTrue: [
		laps timesRepeat: [ aPlayer completeLap ].
	].

	laps < 0 ifTrue: [
		(laps abs) timesRepeat: [ aPlayer undoLap ].
	].

	newIndex := ((rawIndex - 1) \\ size) + 1.

	self place: aPlayer at: newIndex.
]

{ #category : 'accessing' }
Board >> parsecsPerSquare [
	(totalParsecs \\ squares size) ~= 0 ifTrue: [
		self error: 'Parsecs not evenly divisible'
	].
	^ totalParsecs // squares size
]

{ #category : 'behavior' }
Board >> place: aPlayer at: anIndex [

	| newSquare oldSquare |

	newSquare := self squareAt: anIndex.
	oldSquare := aPlayer currentSquare.

	oldSquare ifNotNil: [
		oldSquare removePlayer: aPlayer
	].

	newSquare addPlayer: aPlayer.
	aPlayer moveTo: newSquare.
]

{ #category : 'behavior' }
Board >> place: aPlayer atSquare: aSquare [
	aPlayer moveTo: aSquare
]

{ #category : 'accessing' }
Board >> size [

	^ squares size
]

{ #category : 'accessing' }
Board >> squareAt: aPosition [

	^ squares at: aPosition
]

{ #category : 'accessing' }
Board >> squares [
^ squares 
]

{ #category : 'accessing' }
Board >> stepsForParsecs: parsecs [
	^ parsecs // self parsecsPerSquare
]
