private-socket handling
getSocketOption: option forSocket: socketPointer
	| size more  res|
	more := ZmqApiStructForInt externalNew.
	more value: 1.
	size := ZmqApiSize externalNew.
	size size: ZmqApiStructForInt structureSize.

	res := self executeApiCall: [self apiZmqGetsockoptSocket: socketPointer option: option value: more size: size 
		]. 
	
	^ more value clone