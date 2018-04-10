private-library api
apiZmqContextNew
	self ffiCall: #( ZmqApiContext* zmq_ctx_new (void) ) module: LibZeroMQ
	