private-socket handling
receiveFromSocket: socketPointer message: messagePointer withFlags: flags
	^ self executeApiCall: [self apiZmqReceiveFromSocket: socketPointer  message: messagePointer withFlags: flags] 
