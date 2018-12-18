widgetMessages
executeCommCloseRequest: aMessage
	IPharoKernel instance commManager unregisterComm: (aMessage content at:#comm_id).
	
	"NO-RESPONSE"