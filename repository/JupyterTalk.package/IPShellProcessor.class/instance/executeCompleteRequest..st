private
executeCompleteRequest: aMessage
	| response completionList |

	response := IPCompleteReplyMsg new.
	completionList := self completer getCompletionListFrom: aMessage.
	response content matches: (completionList at:1).
	response content at:#cursor_start put: (completionList at:2).
	response content at:#cursor_end put: (completionList at:3).
	response content at:#status put:#ok. 
	"parent_header must be exactly the same header"
	response respondsToWireMessage: self wireMessage.
	^ response
	