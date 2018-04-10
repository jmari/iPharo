private-library api
apiZmqSendToSocket: socketPointer message: messagePointer withFlags: flags
	self ffiCall: #( long zmq_msg_send (ZmqApiMessage* messagePointer,ZmqApiSocket* socketPointer,long flags) ) module: LibZeroMQ