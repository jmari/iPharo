private-message handling
closeMessage: aZmqApiMessage
	self executeApiCall: [self apiZmqMsgClose: aZmqApiMessage].