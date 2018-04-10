initialization
initialize
	
	super initialize.
	self msgType: #execute_input.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new.