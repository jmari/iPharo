private-library api
apiZmqBind: socket to: endpoint
	self ffiCall: #( long zmq_bind (ZmqApiSocket* socket, char* endpoint) ) module:LibZeroMQ
	