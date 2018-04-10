private-library api
apiZmqInit: threads
	self ffiCall: #( ZmqApiContext* zmq_init (long threads) ) module: LibZeroMQ
	