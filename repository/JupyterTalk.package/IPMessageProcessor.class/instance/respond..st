running
respond: anIPResponse
	| aResponse |
	aResponse := IPWireMessage newFromMessage: anIPResponse.
	self zmqSocket ifNotNil: [ 
		self zmqSocket  
				send: aResponse uuid flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aResponse calculateHMAC hex asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aResponse header flags:ZmqApiConstants  zmqSendMore;
				send: aResponse parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aResponse metadata flags:ZmqApiConstants  zmqSendMore;
				send: aResponse content ]