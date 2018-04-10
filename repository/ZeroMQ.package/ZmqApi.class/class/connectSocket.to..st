private-socket handling
connectSocket: aZmqApiSocket to: aByteString
	Zmq3Api executeApiCall: [Zmq3Api apiZmqConnect: aZmqApiSocket to: aByteString].