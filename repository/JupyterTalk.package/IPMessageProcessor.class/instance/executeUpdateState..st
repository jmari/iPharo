widgetMessages
executeUpdateState: aMessage 
	| response |                
	(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)) commListeners  
	 do:[:aListener|
		response := aListener model state: (aMessage content at:#state)]