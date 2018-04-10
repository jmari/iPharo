private-library api
apiZmqSendToSocket: socketPointer message: messagePointer withFlags: flags
	self ffiCall: #( long zmq_send (ZmqApiSocket* socketPointer, ZmqApiMessage* messagePointer, long flags) ) module: LibZeroMQ