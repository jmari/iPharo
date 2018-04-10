private-library api
apiZmqReceiveFromSocket: socket message:  message withFlags:   flags
  self ffiCall: #( long zmq_recv (ZmqApiSocket* socket, ZmqApiMessage* message, long flags) ) module: LibZeroMQ
  