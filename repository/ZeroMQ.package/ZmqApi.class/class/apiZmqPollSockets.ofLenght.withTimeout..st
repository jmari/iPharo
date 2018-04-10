private-library api
apiZmqPollSockets: aZmqPollItemArray ofLenght: length withTimeout: timeout
	self ffiCall: #(  long zmq_poll (FFIExternalStructure* aZmqPollItemArray, long length, long timeout) ) module: LibZeroMQ
	