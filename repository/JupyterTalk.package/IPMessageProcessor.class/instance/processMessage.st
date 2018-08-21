as yet unclassified
processMessage
	|response|
	self wireMessage isFull ifTrue:[

	response := self wireMessage hmacIsValid 
												ifTrue:[self execute: self wireMessage]
												ifFalse:[IPHMACException signal:'Wrong HMAC'].

	self wireMessage: IPWireMessage new].


						
	
