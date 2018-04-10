as yet unclassified
withResultDo: anOneArgumentBlock
	resultHandler := anOneArgumentBlock.
	resultHandler ifNil: [ self context removeFromPoller: self ] ifNotNil: [ self context addToPoller: self ].

	