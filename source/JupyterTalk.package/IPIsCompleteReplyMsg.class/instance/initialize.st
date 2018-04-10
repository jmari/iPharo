initialization
initialize
	super initialize.
	self msgType: #is_complete_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: {#status->#complete} asSCJsonObject . 
