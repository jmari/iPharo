running
executeCommCloseRequest: aMessage
	IPharoKernel instance removeCommMsgHandlersForChanel: aMessage content commID.
	IPharoKernel instance commChanels removeKey: aMessage content commID ifAbsent:[].
	
	"NO-RESPONSE"