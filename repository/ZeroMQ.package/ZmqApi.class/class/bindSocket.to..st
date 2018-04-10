private-socket handling
bindSocket: aZmqApiSocket to: aByteString
	self executeApiCall: [self apiZmqBind: aZmqApiSocket to:  aByteString ].