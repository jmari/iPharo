testing
ifHasEvents:aBlock
	^self revents > 0 ifTrue: aBlock.