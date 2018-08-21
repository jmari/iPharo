as yet unclassified
startThread
	[	|more|
		self wireMessage: IPWireMessage new.
		self threadStarted.
		more := 1.
		[ self isStopping ] whileFalse:[
			self zmqSocket receiveIfAvailable: [ :messageData|  
							more:= self zmqSocket getOption: ZmqApiConstants zmqRcvMore.
							messageData size > 0 ifTrue:[self pushMessageFrame:messageData].
							more = 0 ifTrue: [ self processMessage ]].	
			Processor yield].
			] forkAt: Processor userSchedulingPriority named: self threadName