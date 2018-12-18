comm handlers
composeResponse: aResult
	| currentWireMessage executionResult |
	currentWireMessage := (IPharoKernel instance processors at:#shell) wireMessage.
	executionResult := IPSession currentSession executeResultMessage 
													respondsToWireMessage: currentWireMessage;
													yourself.	
	executionResult content addAll: aResult.	
	self publish: executionResult.
