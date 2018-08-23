widgetMessages
executeCommMsgRequest: aMessage 
	| response |
	                   
	(IPharoKernel instance commManager commChannelAt:aMessage commID) commMsgHandlers do:[:aMsgHandler|
		response := aMsgHandler value:self value:aMessage.
		response ifNotNil:[self publish: response]].