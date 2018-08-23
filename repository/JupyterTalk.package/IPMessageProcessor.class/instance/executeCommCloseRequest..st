widgetMessages
executeCommCloseRequest: aMessage
	IPharoKernel instance commManager unregisterComm: aMessage content commID.
	
	"NO-RESPONSE"