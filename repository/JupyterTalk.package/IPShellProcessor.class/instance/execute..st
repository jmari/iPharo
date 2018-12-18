running
execute: aWireMessage
	| message response|

	message := IPMsg newFromWireMessage: aWireMessage.
	self publish: (IPKernelStatusBusyMsg new respondsToWireMessage: aWireMessage).
	message msgType = #kernel_info_request ifTrue:[ response:=self executeKernelInfoRequest: message].	
	message msgType = #comm_info_request ifTrue:[ response:=self executeCommInfoRequest: message].			
	message msgType = #execute_request ifTrue:[ response:=self executeExecuteRequest: message].
	message msgType = #is_complete_request ifTrue:[ response:=self executeIsCompleteRequest: message].
	message msgType = #shutdown_request ifTrue:[ self executeShutdown: message].
	message msgType = #complete_request ifTrue:[ response:=self executeCompleteRequest: message].
	"Comm messaging protocol, handlers are implemented in super because iopub also use them"
	message msgType = #comm_open ifTrue:[ self executeCommOpenRequest: message].	
	message msgType = #comm_close ifTrue:[ self executeCommCloseRequest: message].	
	message msgType = #comm_msg ifTrue:[ self executeCommMsgRequest: message].	
	message msgType = #update_state ifTrue:[ self executeUpdateState: message].	
	message msgType = #request_state ifTrue:[ self executeUpdateState: message].	
	response ifNotNil:[self respond: response].
	self publish:  (IPKernelStatusIdleMsg new respondsToWireMessage: aWireMessage).

	