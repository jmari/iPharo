running
executeExecuteRequest: aMessage
	| response session result executionResult |
	"parent_header must be exactly the same header"
	
	session := IPSession session: aMessage header session.
	self publish: (session executeInputMessage
										respondsToWireMessage: wireMessage;
										code:aMessage content code;
										yourself ).	
	[result :=session compileAndEvaluate: aMessage] 
		on:Exception do:[:e| 
			response := (session executionErrorMessage 
									respondsToWireMessage: wireMessage;
									exceptionObject: e;
									yourself).
			self publish: (session executeErrorMessage    
									content: response content;
									respondsToWireMessage: wireMessage;
									yourself)].
					
	aMessage content silent = false
	ifTrue:[
		response ifNil:[
			result ifNotNil:[		
				executionResult := session executeResultMessage 
													respondsToWireMessage: wireMessage;
													yourself.	
				executionResult content addAll:result.				
				self publish:  executionResult].
			response:= session executionOkMessage.
			response respondsToWireMessage: wireMessage ]].

	session increaseExecutionCounter.	
	^ response
	