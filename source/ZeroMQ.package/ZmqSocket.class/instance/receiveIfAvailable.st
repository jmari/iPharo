as yet unclassified
receiveIfAvailable
	monitor
		critical: [ 
			| read messagePointer msg |
			messagePointer := self context zmqApi newMessagePointer.
			self context zmqApi initializeMessage: messagePointer.
			read := self context zmqApi
				receiveFromSocket: self socketPointer
				message: messagePointer
				withFlags: ZmqApiConstants zmqNoBlock.
			read < 0
				ifFalse: [ 
					msg := self context zmqApi messageContent: messagePointer.
					self context zmqApi closeMessage: messagePointer ].
			^ msg ]