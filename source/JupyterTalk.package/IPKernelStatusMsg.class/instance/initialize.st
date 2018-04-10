initialization
initialize
	super initialize.
	self msgType: #status.
	self metadata: SCJsonObject new.
	self parentHeader: '{}' asByteArray. 
	self content: { 
						#execution_state -> self executionState.
						} asSCJsonObject.
