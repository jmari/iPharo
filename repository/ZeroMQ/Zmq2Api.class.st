Class {
	#name : #Zmq2Api,
	#superclass : #ZmqApi,
	#category : 'ZeroMQ-Api'
}

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqInit: threads [
	self ffiCall: #( ZmqApiContext* zmq_init (long threads) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqMsg: message forData: data ofSize: size andWhenFreeCall: functionPtr withArgument: argument [
	self ffiCall: #(  long zmq_msg_init_data (ZmqApiMessage* message, FFIExternalStructure* data, long  size, FFIExternalStructure* functionPtr, FFIExternalStructure* argument) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqMsg: message ofSize: size [
	self ffiCall: #(  long zmq_msg_init_size (ZmqApiMessage* message, long size) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqMsgClose: threads [
	self ffiCall: #( long zmq_msg_close (ZmqApiMessage* threads) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqMsgData: aZmqApiMessage [
	self ffiCall: #( void* zmq_msg_data (ZmqApiMessage* aZmqApiMessage) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqMsgInit: messagePointer [
  self ffiCall: #( long zmq_msg_init (ZmqApiMessage* messagePointer) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqMsgSize: messagePointer [
  self ffiCall: #( long zmq_msg_size (ZmqApiMessage* messagePointer) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqReceiveFromSocket: socket message:  message withFlags:   flags [
  self ffiCall: #( long zmq_recv (ZmqApiSocket* socket, ZmqApiMessage* message, long flags) ) module: LibZeroMQ
  
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqSendToSocket: socketPointer message: messagePointer withFlags: flags [
	self ffiCall: #( long zmq_send (ZmqApiSocket* socketPointer, ZmqApiMessage* messagePointer, long flags) ) module: LibZeroMQ
]

{ #category : #'private-library api' }
Zmq2Api class >> apiZmqTerm: threads [
	self ffiCall: #( long zmq_term (ZmqApiContext* threads) ) module: LibZeroMQ
	
]

{ #category : #'as yet unclassified' }
Zmq2Api class >> newContextPointer [ 
	^self apiZmqInit: 1
]

{ #category : #'as yet unclassified' }
Zmq2Api class >> terminateContextPointer: aZmqApiContextPointer [
	self apiZmqTerm: aZmqApiContextPointer
]
