private-library api
apiZmqReceiveFromSocket: socket message:  message withFlags:   flags
  self ffiCall: #( long zmq_msg_recv (ZmqApiMessage* message, ZmqApiSocket* socket,  long flags) ) module: LibZeroMQ