"
AtomicBomb.
○ Return everyone to the first square.
○ The number of laps each ship completed remains.
○ Remove 1 shield from all ships
"
Class {
	#name : 'AtomicBombSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model-Squares',
	#package : 'IngSoft2-Model',
	#tag : 'Squares'
}

{ #category : 'behavior' }
AtomicBombSquare >> applyEffectTo: aPlayer in: aGame [

	aGame players do: [ :each |
		aGame sendToStart: each
	].
	aGame players do: [ :each |
		each loseShield 
	].
]
