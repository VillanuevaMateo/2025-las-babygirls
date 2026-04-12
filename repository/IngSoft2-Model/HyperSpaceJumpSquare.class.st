"
HyperSpaceJump.
○ Move the ship forward 4 spaces.
○ Lose 1 shield
"
Class {
	#name : 'HyperSpaceJumpSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model-Squares',
	#package : 'IngSoft2-Model',
	#tag : 'Squares'
}

{ #category : 'behavior' }
HyperSpaceJumpSquare >> applyEffectTo: aPlayer in: aBoard [
	aBoard movePlayer: aPlayer by: 4.
	aPlayer loseShield.
]
