private-library api
apiZmqErrno
	self ffiCall: #(long zmq_errno (void)  ) module: LibZeroMQ
	