running
executeCommMsgRequest: aMessage 
	| response |
	                       
	(IPharoKernel instance commMsgHandlerFor:aMessage commID) do:[:aMsgHandler|
		response := aMsgHandler value:self value:aMessage.
		response ifNotNil:[self publish: response]].