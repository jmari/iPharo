running
executeExecuteRequest: aMessage
	| response session result executionResult |
	"parent_header must be exactly the same header"

	[session := IPSession session: aMessage header session]
	on: Error do:[session := IPSession newSessionFor: aMessage header].
	
	self publish: (session executeInputMessage
										respondsToWireMessage: self wireMessage;
										code:aMessage content code;
										yourself ).	
	[result :=session compileAndEvaluate: aMessage] 
		on:Exception do:[:e| 
			response := (session executionErrorMessage 
									respondsToWireMessage: self wireMessage;
									exceptionObject: e;
									yourself).
			self publish: (session executeErrorMessage    
									content: response content;
									respondsToWireMessage: self wireMessage;
									yourself)].
					
	aMessage content silent
	ifFalse:[
		response ifNil:[
			result ifNotNil:[		
				executionResult := session executeResultMessage 
													respondsToWireMessage: wireMessage;
													yourself.	
				executionResult content addAll:result.				
				self publish:  executionResult].
			response:= session executionOkMessage.
			response respondsToWireMessage: self wireMessage ]].

	session increaseExecutionCounter.	
	^ response
	