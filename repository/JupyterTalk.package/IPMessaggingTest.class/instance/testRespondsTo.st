tests
testRespondsTo
	|wm executeMessage wmResp |
	"parentHeader field in a response message must have exactly the same header than the request message
	normally we create response message instance using the session object (IPSession currentSession, it has factory methods for each kind of message
	You have to transform the message to a wireMessage before you send it back to the client"
	wm := self wireMessage.
	executeMessage := self session executeResultMessage  respondsToWireMessage: wm.
	wmResp := IPWireMessage newFromMessage: executeMessage.
	self assert:wm header equals:	wmResp parentHeader	
		
