private-library api
apiZmqStrErrno:errno
	self ffiCall: #(char * zmq_strerrno (long errno)  ) module: LibZeroMQ
	