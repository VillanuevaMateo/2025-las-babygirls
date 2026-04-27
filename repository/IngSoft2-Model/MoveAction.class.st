"
""Represents the decision to advance on the board.
When executed, it triggers the full movement flow in the Game,
including dice roll, movement, landing effects, and combat resolution.""
"
Class {
	#name : 'MoveAction',
	#superclass : 'Action',
	#category : 'IngSoft2-Model-Actions',
	#package : 'IngSoft2-Model',
	#tag : 'Actions'
}

{ #category : 'behavior' }
MoveAction >> executeFor: aPlayer in: aGame [
	aGame performMoveFor: aPlayer
]
