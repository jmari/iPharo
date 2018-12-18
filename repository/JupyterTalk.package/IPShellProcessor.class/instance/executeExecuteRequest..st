running
executeExecuteRequest: aMessage
	| response session  |
	"parent_header must be exactly the same header"

	[session := IPSession session: aMessage header session]
	on: Error do:[session := IPSession newSessionFor: aMessage header].
	session ifNil:[ session := IPSession newSessionFor: aMessage header].
	
	self publish: (session executeInputMessage
										respondsToWireMessage: self wireMessage;
										code:aMessage content code;
										yourself ).	
	[[session compileAndEvaluate: aMessage] 
		on:OCUndeclaredVariableWarning do:["Nothing"]]
		on:Exception do:[:e| 
			response := (session executionErrorMessage 
									respondsToWireMessage: self wireMessage;
									exceptionObject: e;
									yourself).
			self publish: (session executeErrorMessage    
									content: response content;
									respondsToWireMessage: self wireMessage;
									yourself)].
	response ifNil:[
		response:= session executionOkMessage.
		response respondsToWireMessage: self wireMessage ].

	session increaseExecutionCounter.	
	^ response
	