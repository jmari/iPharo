widgetMessages
executeCommMsgRequest: aMessage 
	| comm data |
	                   
	comm :=(IPharoKernel instance commManager commChannelAt:(aMessage content at:#comm_id)). 
	data := aMessage content at:#data.
	(data at:#method) = 'update' ifTrue:[ comm commListeners do:[:l| l updateState:(data at:#state)]].
	(data at:#method) = 'request_state' ifTrue:[ comm commListeners 
		do:[:l| comm update:l model state]].	 
