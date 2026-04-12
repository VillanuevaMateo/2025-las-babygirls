"
MoonWalk.
○ Move all other ships back N spaces.
○ Does not affect the one that landed on the space.
○ The number of spaces N varies for each space, that is, there can be spaces with different N on the same board.
"
Class {
	#name : 'MoonWalkSquare',
	#superclass : 'Square',
	#instVars : [
		'steps'
	],
	#category : 'IngSoft2-Model-Squares',
	#package : 'IngSoft2-Model',
	#tag : 'Squares'
}

{ #category : 'initialization' }
MoonWalkSquare class >> withSteps: aNumber [
	^ self new initializeWithSteps: aNumber
]

{ #category : 'behavior' }
MoonWalkSquare >> applyEffectTo: aPlayer in: aGame [

	| affectedPlayers |

affectedPlayers := aGame players select: [ :each | each ~= aPlayer ].

affectedPlayers do: [ :each |
	aGame movePlayer: each by: steps negated
].
]

{ #category : 'initialization' }
MoonWalkSquare >> initializeWithSteps: aNumber [
	steps := aNumber
]
