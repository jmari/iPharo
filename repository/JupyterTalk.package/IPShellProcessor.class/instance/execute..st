running
execute: aWireMessage
	| message response|

	message := IPMsg newFromWireMessage: aWireMessage.
	self publish: (IPKernelStatusBusyMsg new respondsToWireMessage: wireMessage).
	message msgType = #kernel_info_request ifTrue:[ response:=self executeKernelInfoRequest: message].	
	message msgType = #comm_info_request ifTrue:[ response:=self executeCommInfoRequest: message].			
	message msgType = #execute_request ifTrue:[ response:=self executeExecuteRequest: message].
	message msgType = #is_complete_request ifTrue:[ response:=self executeIsCompleteRequest: message].
	message msgType = #shutdown_request ifTrue:[ self executeShutdown: message].
	"Com messaging protocol, handlers are implemented in super because iopub also use them"
	message msgType = #comm_open ifTrue:[ self executeCommOpenRequest: message].	
	message msgType = #comm_close ifTrue:[ self executeCommCloseRequest: message].	
	message msgType = #comm_msg ifTrue:[ self executeCommMsgRequest: message].	
	
	
	response ifNotNil:[self respond: response].
	self publish:  (IPKernelStatusIdleMsg new respondsToWireMessage: wireMessage).

	