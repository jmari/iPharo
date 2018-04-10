private-message handling
initializeMessage: aZmqApiMessage
	self executeApiCall: [self apiZmqMsgInit: aZmqApiMessage].