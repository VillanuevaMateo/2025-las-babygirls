"
model the game topology and manage the occupancy of the squares
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'squares'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
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

{ #category : 'initialization' }
Board >> initializeWithAmountOfSquares: numberOfSquares [

	squares := OrderedCollection new.
	
	1 to: numberOfSquares do: [ :anIndex |
		squares add: Square new
	].
]

{ #category : 'initialization' }
Board >> initializeWithSquares: initialSquares [

	squares := initialSquares.
	
]

{ #category : 'accessing' }
Board >> isLastSquare: aSquare [

	^ aSquare = squares last
]

{ #category : 'behavior' }
Board >> move: aPlayer forward: steps [

	| currentIndex newIndex size laps |

	currentIndex := squares indexOf: aPlayer currentSquare.
	size := squares size.

	newIndex := currentIndex + steps.

	laps := (newIndex - 1) // size.
	laps > 0 ifTrue: [
		laps timesRepeat: [ aPlayer completeLap ].
	].

	newIndex := ((newIndex - 1) \\ size) + 1.

	self place: aPlayer at: newIndex.
	self resolveLandingOf: aPlayer.
]

{ #category : 'behavior' }
Board >> move: aPlayer using: aDie [

	self move: aPlayer forward: aDie roll.
]

{ #category : 'behavior' }
Board >> place: aPlayer at: aPosition [

	| targetSquare currentSquare |
	
	targetSquare := self squareAt: aPosition.
	currentSquare := aPlayer currentSquare.
	
	currentSquare ifNotNil: [
		currentSquare removePlayer: aPlayer
	].
	
	targetSquare addPlayer: aPlayer.
	aPlayer moveTo: targetSquare.
]

{ #category : 'behavior' }
Board >> place: aPlayer atSquare: aSquare [
	aPlayer moveTo: aSquare
]

{ #category : 'behavior' }
Board >> playTurnFor: aPlayer using: aDie [

	self move: aPlayer using: aDie.
]

{ #category : 'behavior' }
Board >> resolveLandingOf: aPlayer [
	aPlayer currentSquare applyEffectTo: aPlayer in: self
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
