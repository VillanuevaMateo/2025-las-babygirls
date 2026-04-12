"
BlackHole. 
○ Vuelve la nave 4 casilleros hacia atrás. 
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model-Squares',
	#package : 'IngSoft2-Model',
	#tag : 'Squares'
}

{ #category : 'behavior' }
BlackHoleSquare >> applyEffectTo: aPlayer in: aBoard [
	aBoard movePlayer: aPlayer by: -4
]
