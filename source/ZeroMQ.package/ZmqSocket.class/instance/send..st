as yet unclassified
send: aByteArray
	monitor
		critical: [ 
			| messagePointer |
			self waitForUnpark.
			messagePointer := self context zmqApi messageFromByteArray: aByteArray.
			self context zmqApi executeApiCall: [ self context zmqApi apiZmqSendToSocket: self socketPointer message: messagePointer withFlags: 0 ].
			self context zmqApi executeApiCall: [ self context zmqApi apiZmqMsgClose: messagePointer ].
			self logDebug: 'Sended ' , aByteArray asString ]