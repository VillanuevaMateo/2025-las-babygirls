"
Cards that can be played by a player in his turn
"
Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'validation' }
PermanentCard >> canBePlayedBy: aPlayer in: aGame [

	^ (aGame hasWinner not)
		and: [ aGame currentPlayer = aPlayer ]
]
