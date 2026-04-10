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

{ #category : 'initialization' }
Board >> initializeWithAmountOfSquares: numberOfSquares [

	squares := OrderedCollection new.
	
	1 to: numberOfSquares do: [ :anIndex |
		squares add: Square new
	].
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
]

{ #category : 'behavior' }
Board >> move: aPlayer using: aDie [

	self move: aPlayer forward: aDie roll.
]

{ #category : 'accessing' }
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
Board >> playTurnFor: aPlayer using: aDie [

	self move: aPlayer using: aDie.
]

{ #category : 'accessing' }
Board >> size [

	^ squares size
]

{ #category : 'accessing' }
Board >> squareAt: aPosition [

	^ squares at: aPosition
]
