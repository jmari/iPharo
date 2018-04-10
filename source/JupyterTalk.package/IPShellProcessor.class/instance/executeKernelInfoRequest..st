running
executeKernelInfoRequest: aMessage
	| response session|
	
	session := IPSession newSessionFor: aMessage header.
	response := session kernelInfoReplayMessage.
	"must be exactly the same header"
	response respondsToWireMessage: wireMessage.

	^  response
	