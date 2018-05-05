tests
testIPWireMessageHMAC
	|wm|
	wm := self wireMessage.
	self assert:wm hmacIsValid 		
		
