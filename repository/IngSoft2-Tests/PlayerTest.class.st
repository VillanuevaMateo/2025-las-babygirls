Class {
	#name : 'PlayerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests-Board-Tests',
	#package : 'IngSoft2-Tests',
	#tag : 'Board-Tests'
}

{ #category : 'tests - initialization' }
PlayerTest >> testCreatePlayerWithName [

	| aPlayer |
	
	aPlayer := Player named: 'Player 1'.
	
	self assert: aPlayer name equals: 'Player 1'.
]

{ #category : 'tests - properties' }
PlayerTest >> testPlayerKnowsItsCurrentSquare [

	| aSquare aPlayer |
	
	aSquare := Square new.
	aPlayer := Player named: 'Player 1'.
	
	aPlayer moveTo: aSquare.
	
	self assert: aPlayer currentSquare equals: aSquare.
]

{ #category : 'tests - initialization' }
PlayerTest >> testPlayerNameCannotBeEmpty [

	self should: [ Player named: '' ] raise: Error.
]
