private-library api
apiZmqSetsockoptSocket: socket option: option value: value size:  size
	self ffiCall: #( long zmq_setsockopt (ZmqApiSocket* socket, long option, void* value, long size) ) module: LibZeroMQ
	