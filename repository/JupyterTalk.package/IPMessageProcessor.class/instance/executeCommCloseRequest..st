widgetMessages
executeCommCloseRequest: aMessage
	IPharoKernel instance commManager removeMsgHandlersForChanel: aMessage content commID.
	IPharoKernel instance commManager commChanels removeKey: aMessage content commID ifAbsent:[].
	
	"NO-RESPONSE"