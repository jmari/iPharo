as yet unclassified
send: aByteArray flags: aZmqFlags
	monitor
		critical: [ 
			| messagePointer |
			self waitForUnpark.
			messagePointer := self context zmqApi messageFromByteArray: aByteArray.
			self context zmqApi executeApiCall: [ self context zmqApi apiZmqSendToSocket: self socketPointer message: messagePointer withFlags: aZmqFlags]. 
			self context zmqApi executeApiCall: [ self context zmqApi apiZmqMsgClose: messagePointer ]].
			self logDebug: 'Sent ' , aByteArray asString 