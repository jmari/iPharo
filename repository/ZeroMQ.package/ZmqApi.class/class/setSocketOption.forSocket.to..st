private-socket handling
setSocketOption: option forSocket: socketPointer to: value
	| data size |
	data := 	value asByteArray.
	size := data size.
	self executeApiCall: [self apiZmqSetsockoptSocket: socketPointer option: option value: data size: size].  