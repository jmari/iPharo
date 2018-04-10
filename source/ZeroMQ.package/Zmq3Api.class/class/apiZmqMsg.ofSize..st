private-library api
apiZmqMsg: message ofSize: size
	self ffiCall: #(  long zmq_msg_init_size (ZmqApiMessage* message, long size) ) module: LibZeroMQ
	