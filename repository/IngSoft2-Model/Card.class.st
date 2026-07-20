"
Cards that can be played by a player
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'accessing' }
Card class >> random [

	| cardTypes |
	cardTypes := {
		InstantCard.
		PermanentCard
	}.
	^(cardTypes atRandom) new.
]

{ #category : 'behavior' }
Card >> applyTo: aGame playedBy: aPlayer [ 
	^ self
]

{ #category : 'validation' }
Card >> canBePlayedBy: aPlayer in: aGame [

	self subclassResponsibility.
]
