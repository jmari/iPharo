private-library api
apiZmqContextDestroy: aZmqApiContext
	self ffiCall: #( long zmq_ctx_destroy (ZmqApiContext* aZmqApiContext) ) module: LibZeroMQ
	