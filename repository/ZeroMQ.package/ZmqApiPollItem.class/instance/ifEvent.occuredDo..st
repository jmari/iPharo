testing
ifEvent: bitMask occuredDo:  aBlock
	^(self hasEventMask: bitMask) ifTrue: aBlock.