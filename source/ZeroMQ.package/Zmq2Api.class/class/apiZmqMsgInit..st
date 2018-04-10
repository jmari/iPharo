private-library api
apiZmqMsgInit: messagePointer
  self ffiCall: #( long zmq_msg_init (ZmqApiMessage* messagePointer) ) module: LibZeroMQ
	