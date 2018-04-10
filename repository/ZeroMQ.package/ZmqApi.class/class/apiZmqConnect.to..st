private-library api
apiZmqConnect: socket to: endpoint
	self ffiCall: #( long zmq_connect (ZmqApiSocket* socket, char* endpoint) ) module:LibZeroMQ
	