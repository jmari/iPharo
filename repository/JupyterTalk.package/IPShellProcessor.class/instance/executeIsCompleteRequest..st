running
executeIsCompleteRequest: aMessage
	| response |
	response := IPIsCompleteReplyMsg new.
	"parent_header must be exactly the same header"
	response respondsToWireMessage: wireMessage.
	^ response
	