Class {
	#name : #ZmqApi,
	#superclass : #Object,
	#category : #'ZeroMQ-Api'
}

{ #category : #'private-library api' }
ZmqApi class >> apiZmqBind: socket to: endpoint [
	self ffiCall: #( long zmq_bind (ZmqApiSocket* socket, char* endpoint) ) module:LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqClose: socket [
	self ffiCall: #( long zmq_close (ZmqApiSocket* socket) ) module:LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqConnect: socket to: endpoint [
	self ffiCall: #( long zmq_connect (ZmqApiSocket* socket, char* endpoint) ) module:LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqErrno [
	self ffiCall: #(long zmq_errno (void)  ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqPollSockets: aZmqPollItemArray ofLenght: length withTimeout: timeout [
	self ffiCall: #(  long zmq_poll (FFIExternalStructure* aZmqPollItemArray, long length, long timeout) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqSetsockoptSocket: socket option: option value: value size:  size [
	self ffiCall: #( long zmq_setsockopt (ZmqApiSocket* socket, long option, void* value, long size) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqSocketInContext: context socketType: type [
	self ffiCall: #( ZmqApiSocket* zmq_socket (ZmqApiContext* context,long type) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
ZmqApi class >> apiZmqVersion: major minor: minor patch: patch [
	self ffiCall: #(  void zmq_version (ZmqApiStructForInt* major, int* minor, int* patch) ) module: LibZeroMQ
	
]

{ #category : #'private-socket handling' }
ZmqApi class >> bindSocket: aZmqApiSocket to: aByteString [
	self executeApiCall: [self apiZmqBind: aZmqApiSocket to:  aByteString ].
]

{ #category : #'private-message handling' }
ZmqApi class >> closeMessage: aZmqApiMessage [
	self executeApiCall: [self apiZmqMsgClose: aZmqApiMessage].
]

{ #category : #'private-socket handling' }
ZmqApi class >> closeSocket: aZmqApiSocket [
	^self executeApiCall: [self apiZmqClose: aZmqApiSocket ].
]

{ #category : #'private-socket handling' }
ZmqApi class >> connectSocket: aZmqApiSocket to: aByteString [
	Zmq3Api executeApiCall: [Zmq3Api apiZmqConnect: aZmqApiSocket to: aByteString].
]

{ #category : #'public api' }
ZmqApi class >> context [
	^ZmqContext current
]

{ #category : #'private-api conveniency' }
ZmqApi class >> executeApiCall: aBlock [
	| retVal tryAgains |
	retVal := aBlock value.
	tryAgains := {(ZmqApiConstants errnoEAGAIN).
	(ZmqApiConstants errnoEINTR)}.
	retVal < 0
		ifTrue: [ 
			| errno |
			errno := self apiZmqErrno.
			(tryAgains includes: errno)
				ifFalse: [ 
					self signalErrno: errno. ] ].
	^ retVal
]

{ #category : #'as yet unclassified' }
ZmqApi class >> forCurrentVersion [
	(self version between: '2.0.0' and: '2.9.0')
		ifTrue: [ ^ Zmq2Api ].
	(self version between: '3.0.0' and: '3.3.0')
		ifTrue: [ ^ Zmq3Api ].
	(self version between: '4.0.0' and: '4.2.3')
		ifTrue: [ ^ Zmq4Api ].

	 ^ Zmq4Api 
	"Why is it failing when jupyter runs the kerner?"
	"self error: 'Does not know what version to use for version ' , self version asString"
]

{ #category : #'private-socket handling' }
ZmqApi class >> getSocketOption: option forSocket: socketPointer [
	| size more  res|
	more := ZmqApiStructForInt externalNew.
	more value: 1.
	size := ZmqApiSize externalNew.
	size size: ZmqApiStructForInt structureSize.

	res := self executeApiCall: [self apiZmqGetsockoptSocket: socketPointer option: option value: more size: size 
		]. 
	
	^ more value clone
]

{ #category : #'private-message handling' }
ZmqApi class >> initializeMessage: aZmqApiMessage [
	self executeApiCall: [self apiZmqMsgInit: aZmqApiMessage].
]

{ #category : #'as yet unclassified' }
ZmqApi class >> lastZmqError [
	| errno |
	errno := self apiZmqErrno.
	^ (self zmqErrnoAsString: errno)
]

{ #category : #'as yet unclassified' }
ZmqApi class >> messageClass [
	^ ZmqApiMessage
]

{ #category : #'private-message handling' }
ZmqApi class >> messageContent: aZmqApiMessage [
	| externalData size array|
	externalData := self apiZmqMsgData: aZmqApiMessage.
	size := self apiZmqMsgSize: aZmqApiMessage.
	array := ByteArray new: size.

	1 to: size do: [:i|
		array at: i put: (externalData getHandle unsignedByteAt: i).
	].
	^array.
]

{ #category : #'private-message handling' }
ZmqApi class >> messageFromByteArray: aByteArray [
	  | messagePointer dataPointer size null |
	size := aByteArray size.
	null := (FFIExternalStructure fromHandle: ExternalAddress new beNull).
	dataPointer := ExternalAddress allocate: size.
	messagePointer := self newMessagePointer.
	aByteArray withIndexDo: [:b :i| dataPointer byteAt: i put: b].	
	self apiZmqMsg: messagePointer forData: (FFIExternalStructure fromHandle: dataPointer) ofSize: size andWhenFreeCall: null withArgument: null .
	^messagePointer.
]

{ #category : #'as yet unclassified' }
ZmqApi class >> newMessagePointer [ 
	^ self messageClass externalNew.
]

{ #category : #'private-api conveniency' }
ZmqApi class >> pollApiCall: aBlock [
	"Polls non blocking Api call until it returns a result."

	| retVal |
	[ 
	retVal := self executeApiCall: aBlock.
	retVal < 0 ] whileTrue: [ Processor yield ].
	^ retVal
]

{ #category : #'private-socket handling' }
ZmqApi class >> receiveFromSocket: socketPointer message: messagePointer [
	self pollApiCall: [self apiZmqReceiveFromSocket: socketPointer message: messagePointer withFlags: ZmqApiConstants zmqNoBlock] 

]

{ #category : #'private-socket handling' }
ZmqApi class >> receiveFromSocket: socketPointer message: messagePointer withFlags: flags [
	^ self executeApiCall: [self apiZmqReceiveFromSocket: socketPointer  message: messagePointer withFlags: flags] 

]

{ #category : #'private-socket handling' }
ZmqApi class >> setSocketOption: option forSocket: socketPointer to: value [
	| data size |
	data := 	value asByteArray.
	size := data size.
	self executeApiCall: [self apiZmqSetsockoptSocket: socketPointer option: option value: data size: size].  
]

{ #category : #'private-api conveniency' }
ZmqApi class >> signalErrno: errno [
	| msg |
	msg := 'ZMQ Error: ' , (self zmqErrnoAsString: errno).
	ZmqLog logError: msg.
	Error signal: msg
]

{ #category : #'public api' }
ZmqApi class >> version [
	| major minor patch version |
	major := ZmqApiStructForInt externalNew.
	minor := ZmqApiStructForInt externalNew.
	patch := ZmqApiStructForInt externalNew.
	self apiZmqVersion:  major minor:  minor patch:  patch.
	version := ZmqVersion major: major value minor: minor value patch: patch value.
	^version.

]

{ #category : #'as yet unclassified' }
ZmqApi class >> zmqErrnoAsString: errno [
	^ errno asString.
]

{ #category : #'public api' }
ZmqApi class >> zmqVersion [
	^ self version

]
