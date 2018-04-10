tests
testPullAndPushInproc
	| push pull1 pull2 message1 message2 fromPull1 fromPull2 |
	push := self newPushSocket bind: 'inproc://asdasd'.
	pull1 := self newPullSocket connect: 'inproc://asdasd'.
	pull2 := self newPullSocket connect: 'inproc://asdasd'.
	message1 := 'Message1' asByteArray.
	message2 := 'Message2' asByteArray.	
	push send: message1.
	push send: message2.	
	fromPull1 := pull1 receive.
	fromPull2 := pull2 receive.	

	self assert: fromPull1 equals: message1.
	self assert: fromPull2 equals: message2.