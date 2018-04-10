private-library api
apiZmqTerm: threads
	self ffiCall: #( long zmq_term (ZmqApiContext* threads) ) module: LibZeroMQ
	