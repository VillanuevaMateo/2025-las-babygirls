"
knows the distribution assigned for each type of square
"
Class {
	#name : 'SquareDistribution',
	#superclass : 'Object',
	#category : 'IngSoft2-Model-SquareDistribution ',
	#package : 'IngSoft2-Model',
	#tag : 'SquareDistribution '
}

{ #category : 'behavior' }
SquareDistribution >> generateSquares: amount [

	| squares wormHoleA wormHoleB positions |

	squares := OrderedCollection new.

	amount timesRepeat: [
		squares add: self randomSquare
	].

	"crear wormholes"
	wormHoleA := WormHoleSquare new.
	wormHoleB := WormHoleSquare new.
	wormHoleA pairWith: wormHoleB.

	"elegir dos posiciones distintas"
	positions := self randomTwoDistinctPositionsIn: amount.

	squares at: positions first put: wormHoleA.
	squares at: positions second put: wormHoleB.

	^ squares
]

{ #category : 'behavior' }
SquareDistribution >> randomSquare [

	| roll |

	roll := Random new next. "0 to 1"

	roll < 0.02 ifTrue: [ ^ AtomicBombSquare new ].
	roll < 0.10 ifTrue: [ ^ HyperJumpSquare new ].
	roll < 0.20 ifTrue: [ ^ MoonWalkSquare new ].
	roll < 0.40 ifTrue: [ ^ HyperSpaceJumpSquare new ].
	roll < 0.60 ifTrue: [ ^ BlackHoleSquare new ].

	^ Square new
]

{ #category : 'behavior' }
SquareDistribution >> randomTwoDistinctPositionsIn: amount [

	| first second random |

	random := Random new.

	first := random nextInteger: amount.

	second := first.
	[ second = first ] whileTrue: [
		second := random nextInteger: amount
	].

	^ { first. second }
]
