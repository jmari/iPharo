private-library api
apiZmqMsg: message forData: data ofSize: size andWhenFreeCall: functionPtr withArgument: argument
	self ffiCall: #(  long zmq_msg_init_data (ZmqApiMessage* message, FFIExternalStructure* data, long  size, FFIExternalStructure* functionPtr, FFIExternalStructure* argument) ) module: LibZeroMQ
	