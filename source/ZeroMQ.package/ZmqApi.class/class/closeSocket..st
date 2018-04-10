private-socket handling
closeSocket: aZmqApiSocket
	^self executeApiCall: [self apiZmqClose: aZmqApiSocket ].