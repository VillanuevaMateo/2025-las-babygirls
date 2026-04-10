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

{ #category : 'initialization' }
Board >> initializeWithAmountOfSquares: numberOfSquares [

	squares := OrderedCollection new.
	
	1 to: numberOfSquares do: [ :anIndex |
		squares add: Square new
	].
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

{ #category : 'accessing' }
Board >> size [

	^ squares size
]

{ #category : 'accessing' }
Board >> squareAt: aPosition [

	^ squares at: aPosition
]
