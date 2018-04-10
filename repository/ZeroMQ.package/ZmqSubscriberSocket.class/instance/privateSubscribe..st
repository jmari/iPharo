private
privateSubscribe: aByteArray
	self context zmqApi setSocketOption: ZmqApiConstants zmqSubscribe forSocket: self socketPointer to: aByteArray.  