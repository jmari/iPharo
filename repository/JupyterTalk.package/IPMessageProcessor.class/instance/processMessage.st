as yet unclassified
processMessage
	|response|
	wireMessage isFull ifTrue:[

	response := wireMessage hmacIsValid 
												ifTrue:[self execute:wireMessage]
												ifFalse:[IPHMACException signal:'Wrong HMAC'].

	wireMessage := IPWireMessage new].


						
	
