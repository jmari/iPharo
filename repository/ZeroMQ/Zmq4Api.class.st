Class {
	#name : #Zmq4Api,
	#superclass : #Zmq3Api,
	#category : #'ZeroMQ-Api'
}

{ #category : #'private-library api' }
Zmq4Api class >> apiZmqGetsockoptSocket: socket option: option value: value size: size [
	self ffiCall: #(long zmq_getsockopt (ZmqApiSocket* socket, long option, ZmqApiStructForInt* value, ZmqApiSize* size) ) module: LibZeroMQ
	
]

{ #category : #'private-library api' }
Zmq4Api class >> apiZmqProxyFrontEnd: frontEndSocketPointer backEnd: backEndSocketPointer capture: captureSocketPointer [
	self ffiCall: #( int zmq_proxy (ZmqApiSocket* frontEndSocketPointer, ZmqApiSocket* backEndSocketPointer, ZmqApiSocket* captureSocketPointer) ) module: LibZeroMQ
]

{ #category : #'private-library api' }
Zmq4Api class >> apiZmqReceiveFromSocket: socket message:  message withFlags:   flags [
  self ffiCall: #( long zmq_msg_recv (ZmqApiMessage* message, ZmqApiSocket* socket,  long flags) ) module: LibZeroMQ
]

{ #category : #'private-library api' }
Zmq4Api class >> apiZmqSendToSocket: socketPointer message: messagePointer withFlags: flags [
	self ffiCall: #( long zmq_msg_send (ZmqApiMessage* messagePointer,ZmqApiSocket* socketPointer,long flags) ) module: LibZeroMQ
]
