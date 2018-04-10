private-library api
apiZmqMsgSize: messagePointer
  self ffiCall: #( long zmq_msg_size (ZmqApiMessage* messagePointer) ) module: LibZeroMQ
	