private-library api
apiZmqSocketInContext: context socketType: type
	self ffiCall: #( ZmqApiSocket* zmq_socket (ZmqApiContext* context,long type) ) module: LibZeroMQ
	