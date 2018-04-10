running
executeCommInfoRequest: aMessage
	| response |
	response := IPCommInfoReplyMsg new.
	"parent_header must be exactly the same header"
	response respondsToWireMessage: wireMessage.
	^  response
	