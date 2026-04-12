"
This die is mocked, it has a sertain sequence. Test purposes.
"
Class {
	#name : 'MockedSequencedDie',
	#superclass : 'Die',
	#instVars : [
		'sequence',
		'nextRoll'
	],
	#category : 'IngSoft2-Model-Game',
	#package : 'IngSoft2-Model',
	#tag : 'Game'
}

{ #category : 'initialize' }
MockedSequencedDie class >> withSequence: aSequence [
	^ self new initializeWithSequence: aSequence
]

{ #category : 'initialization' }
MockedSequencedDie >> initializeWithSequence: aSequence [

sequence := aSequence.
nextRoll := 0.
]

{ #category : 'behavior' }
MockedSequencedDie >> roll [

	| value |

	value := sequence at: nextRoll + 1.

	nextRoll := nextRoll + 1.
	nextRoll = sequence size ifTrue: [
		nextRoll := 0
	].

	^ value
]
