"
este es un casillero en el cual si cae la 
nave se trasladará al otro extremo
"
Class {
	#name : 'WormHoleSquare',
	#superclass : 'Square',
	#instVars : [
		'pairedSquare'
	],
	#category : 'IngSoft2-Model-Board',
	#package : 'IngSoft2-Model',
	#tag : 'Board'
}

{ #category : 'behavior' }
WormHoleSquare >> applyEffectTo: aPlayer in: aBoard [
	aBoard place: aPlayer atSquare: pairedSquare.
]

{ #category : 'setting holes' }
WormHoleSquare >> pairWith: anotherWormHole [
	pairedSquare := anotherWormHole.
	anotherWormHole setPair: self.
]

{ #category : 'accessing' }
WormHoleSquare >> pairedSquare [
	^ pairedSquare
]

{ #category : 'setting holes' }
WormHoleSquare >> setPair: aWormHole [
	pairedSquare := aWormHole.
]
