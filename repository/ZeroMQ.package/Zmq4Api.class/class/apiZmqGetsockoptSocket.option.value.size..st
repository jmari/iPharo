private-library api
apiZmqGetsockoptSocket: socket option: option value: value size: size
	self ffiCall: #(long zmq_getsockopt (ZmqApiSocket* socket, long option, ZmqApiStructForInt* value, ZmqApiSize* size) ) module: LibZeroMQ
	