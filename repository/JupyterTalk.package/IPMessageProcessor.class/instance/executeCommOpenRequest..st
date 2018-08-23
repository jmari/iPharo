widgetMessages
executeCommOpenRequest: aMessage
	|comm|
	"content must be	{		comm_id : uuid,		target_name: key,		data:{}	}"
									
	comm := IPComm new: (aMessage content at:#comm_id).
	comm data:	aMessage content data.
	IPharoKernel instance commManager 
									instanceForTargetClass: (aMessage content at:#target_name)
									usingComm: comm.

	"NO-RESPONSE"