as yet unclassified
publish: anIPMessage
	| aMessage |
	aMessage := IPWireMessage newFromMessage: anIPMessage.
	self zmqSocket  
				send: ('kernel.',anIPMessage uuid asString ,'.',anIPMessage msgType) asByteArray  flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage calculateHMAC hex asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage header flags:ZmqApiConstants  zmqSendMore;
				send: aMessage parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aMessage metadata flags:ZmqApiConstants  zmqSendMore;
				send: aMessage content  