private-library api
apiZmqClose: socket
	self ffiCall: #( long zmq_close (ZmqApiSocket* socket) ) module:LibZeroMQ
	