testing
ifReadEvent:aBlock
	^self ifEvent: ZmqApiConstants zmqPollIn occuredDo: aBlock.