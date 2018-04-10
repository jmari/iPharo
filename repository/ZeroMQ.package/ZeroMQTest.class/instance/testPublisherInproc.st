tests
testPublisherInproc
	| publisher subscriber1 subscriber2 fromSub1 fromSub2 message1 |
	publisher := self newPublisherSocket bind: 'inproc://#1'.
	subscriber1 := self newSubscriberSocket connect: 'inproc://#1'.
	subscriber2 := self newSubscriberSocket connect: 'inproc://#1'.
	subscriber1 subscribeAll.
	subscriber2 subscribeAll.	
	message1 := 'Message1' asByteArray.
	publisher send: message1.
	fromSub1 := subscriber1 receive.
	fromSub2 := subscriber2 receive.	

	self assert: fromSub1 equals: message1.
	self assert: fromSub2 equals: message1.