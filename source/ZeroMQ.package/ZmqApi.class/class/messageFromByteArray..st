private-message handling
messageFromByteArray: aByteArray
	  | messagePointer dataPointer size null |
	size := aByteArray size.
	null := (FFIExternalStructure fromHandle: ExternalAddress new beNull).
	dataPointer := ExternalAddress allocate: size.
	messagePointer := self newMessagePointer.
	aByteArray withIndexDo: [:b :i| dataPointer byteAt: i put: b].	
	self apiZmqMsg: messagePointer forData: (FFIExternalStructure fromHandle: dataPointer) ofSize: size andWhenFreeCall: null withArgument: null .
	^messagePointer.