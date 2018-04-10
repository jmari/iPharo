private-library api
apiZmqStrError:errno
	self ffiCall: #(char * zmq_strerror (long errno)  ) module: LibZeroMQ
	