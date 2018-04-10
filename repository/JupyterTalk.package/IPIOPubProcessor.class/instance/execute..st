running
execute: aWireMessage
	| message |

	message := IPMsg newFromWireMessage: aWireMessage.
	self publish: (IPKernelStatusBusyMsg new respondsToWireMessage: wireMessage).
	message msgType = #comm_open ifTrue:[ self executeCommOpenRequest: message].	
	message msgType = #comm_close ifTrue:[ self executeCommCloseRequest: message].	
	message msgType = #comm_msg ifTrue:[ self executeCommMsgRequest: message].	

	self publish:  (IPKernelStatusIdleMsg new respondsToWireMessage: wireMessage).