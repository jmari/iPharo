initialization
initialize
	super initialize.
	self msgType: #execute_reply.
	self parentHeader: '{}' asByteArray .
	self metadata:{ 
						#dependencies_met->true.
						#started-> DateAndTime now asString.
						#status -> self status.
						} asSCJsonObject.
	self content: { 
						#status -> self status.
						} asSCJsonObject.
