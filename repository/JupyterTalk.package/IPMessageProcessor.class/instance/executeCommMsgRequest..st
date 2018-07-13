widgetMessages
executeCommMsgRequest: aMessage 
	| response |
	                       
	(IPharoKernel instance msgHandlerFor:aMessage commID) do:[:aMsgHandler|
		response := aMsgHandler value:self value:aMessage.
		response ifNotNil:[self publish: response]].