as yet unclassified
startThread
	[	|more|
		self wireMessage: IPWireMessage new.
		self threadStarted.
		more := 1.
		[ self isStopping ] whileFalse:[
			self receiveWireMessage.
			Processor yield].
			] forkAt: Processor userSchedulingPriority named: self threadName