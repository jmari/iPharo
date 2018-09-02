as yet unclassified
receiveWireMessage
	|more|
	self zmqSocket receiveIfAvailable: [ :messageData|  
							more:= self zmqSocket getOption: ZmqApiConstants zmqRcvMore.
							messageData size > 0 ifTrue:[self pushMessageFrame:messageData].
							more = 0 ifTrue: [ self processMessage ]].	