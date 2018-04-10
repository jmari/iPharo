private-library api
apiZmqMsgClose: threads
	self ffiCall: #( long zmq_msg_close (ZmqApiMessage* threads) ) module: LibZeroMQ
	