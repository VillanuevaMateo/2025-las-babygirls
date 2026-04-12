"
BlackHole.
○ Move the ship back 4 spaces.
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Square',
	#instVars : [
		'parsecValues',
		'currentIndex'
	],
	#category : 'IngSoft2-Model-Squares',
	#package : 'IngSoft2-Model',
	#tag : 'Squares'
}

{ #category : 'initialization' }
HyperJumpSquare class >> withParsecValues: aCollection [
	^ self new initializeWithParsecValues: aCollection
]

{ #category : 'behavior' }
HyperJumpSquare >> applyEffectTo: aPlayer in: aGame [

	| parsecs steps |

	parsecs := self nextParsecValue.

	steps := aGame stepsForParsecs: parsecs.

	aGame movePlayer: aPlayer by: steps
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWithParsecValues: aCollection [
	parsecValues := aCollection.
	currentIndex := 1.
]

{ #category : 'accessing' }
HyperJumpSquare >> nextParsecValue [

	| value |

	value := parsecValues at: currentIndex.

	currentIndex := currentIndex + 1.
	currentIndex > parsecValues size ifTrue: [
		currentIndex := 1
	].

	^ value
]
