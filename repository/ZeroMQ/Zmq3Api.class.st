Class {
	#name : #Zmq3Api,
	#superclass : #ZmqApi,
	#category : 'ZeroMQ-Api'
}

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqContextDestroy: aZmqApiContext [
	self ffiCall: #( long zmq_ctx_destroy (ZmqApiContext* aZmqApiContext) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqContextNew [
	self ffiCall: #( ZmqApiContext* zmq_ctx_new (void) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqMsg: message forData: data ofSize: size andWhenFreeCall: functionPtr withArgument: argument [
	self ffiCall: #(  long zmq_msg_init_data (ZmqApiMessage* message, FFIExternalStructure* data, long  size, FFIExternalStructure* functionPtr, FFIExternalStructure* argument) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqMsg: message ofSize: size [
	self ffiCall: #(  long zmq_msg_init_size (ZmqApiMessage* message, long size) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqMsgClose: threads [
	self ffiCall: #( long zmq_msg_close (ZmqApiMessage* threads) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqMsgData: aZmqApiMessage [
	self ffiCall: #( void* zmq_msg_data (ZmqApiMessage* aZmqApiMessage) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqMsgInit: messagePointer [
  self ffiCall: #( long zmq_msg_init (ZmqApiMessage* messagePointer) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqMsgSize: messagePointer [
  self ffiCall: #( long zmq_msg_size (ZmqApiMessage* messagePointer) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqReceiveFromSocket: socket message:  message withFlags:   flags [
  self ffiCall: #( long zmq_recvmsg (ZmqApiSocket* socket, ZmqApiMessage* message, long flags) ) module: LibZeroMQ
  
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqSendToSocket: socketPointer message: messagePointer withFlags: flags [
	self ffiCall: #( long zmq_sendmsg (ZmqApiSocket* socketPointer,ZmqApiMessage* messagePointer,long flags) ) module: LibZeroMQ
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqStrErrno:errno [
	self ffiCall: #(char * zmq_strerrno (long errno)  ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq3Api class >> apiZmqStrError:errno [
	self ffiCall: #(char * zmq_strerror (long errno)  ) module: LibZeroMQ
	
]

{ #category : #'as yet unclassified' }
Zmq3Api class >> newContextPointer [ 
	^self apiZmqContextNew.
]

{ #category : #'as yet unclassified' }
Zmq3Api class >> terminateContextPointer: aZmqApiContextPointer [
	self apiZmqContextDestroy: aZmqApiContextPointer
]

{ #category : #'as yet unclassified' }
Zmq3Api class >> zmqErrnoAsString: errno [
	^ errno asString , ': ' , (self apiZmqStrError: errno)
]
