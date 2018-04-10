initialization
initialize
	super initialize.
	self msgType: #comm_info_reply.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: IPharoKernel instance commChanels asSCJsonObject. 
