private-library api
apiZmqMsgData: aZmqApiMessage
	self ffiCall: #( void* zmq_msg_data (ZmqApiMessage* aZmqApiMessage) ) module: LibZeroMQ
	