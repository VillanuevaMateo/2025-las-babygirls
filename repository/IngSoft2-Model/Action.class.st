"
""Represents a player decision during their turn.
Subclasses define specific intentions and delegate execution to the Game,
which is responsible for enforcing rules and orchestrating the turn flow.""
"
Class {
	#name : 'Action',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-Actions',
	#package : 'IngSoft2-Model',
	#tag : 'Actions'
}

{ #category : 'behavior' }
Action >> executeFor: aPlayer in: aGame [
	aPlayer rest
]
