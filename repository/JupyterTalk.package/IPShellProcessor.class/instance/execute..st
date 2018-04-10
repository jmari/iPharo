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
	response ifNotNil:[self respond: response].
	self publish:  (IPKernelStatusIdleMsg new respondsToWireMessage: wireMessage).

	