"
Cards that can be played by a player at any moment
"
Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'validation' }
InstantCard >> canBePlayedBy: aPlayer in: aGame [

	^ aGame hasWinner not
]
