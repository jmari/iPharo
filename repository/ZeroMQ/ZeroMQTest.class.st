Class {
	#name : #ZeroMQTest,
	#superclass : #ZmqBaseTest,
	#category : 'ZeroMQ-Tests'
}

{ #category : #tests }
ZeroMQTest >> testPairInproc [
	|pair1 pair2 result|
	pair1 := self newPairSocket bind: 'inproc://#1'.
	pair2 := self newPairSocket connect: 'inproc://#1'.
	pair1 send: 'OK' asByteArray.
	result := pair2 receive.

	self assert: result asString = 'OK'.
	
]

{ #category : #tests }
ZeroMQTest >> testPublisherInproc [
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
]

{ #category : #tests }
ZeroMQTest >> testPullAndPushInproc [
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
]

{ #category : #tests }
ZeroMQTest >> testPullWithResultDo [
	| push pull resultReceived message1 |
	resultReceived := false.
	push := self newPushSocket  bind: 'inproc://pullwithresults'.
	pull := self newPullSocket connect: 'inproc://pullwithresults'.
	pull withResultDo: [ 
		Transcript show:'ohhhh'.
		resultReceived := true ].
	message1 := 'Message1' asByteArray.
	push send: message1.
	Transcript show: 'asd'.
	self should: [
		[(Delay forMilliseconds: 1) wait.  resultReceived] whileFalse.
		] notTakeMoreThanMilliseconds: 50.

]

{ #category : #tests }
ZeroMQTest >> testReqRepWithResultDo [
	| resultReceived req rep s |
	resultReceived := false.
	s := 'inproc://1234'.
	req := self newReqSocket bind: s.
	rep := self newRepSocket connect: s.
	req
		withResultDo: [ 
			resultReceived := true.
			].
	rep
		withResultDo: [ :r | 
			Transcript show: 'got stuff'.
			rep send: r asByteArray ].
	req send: 'viesti' asByteArray.
	self should: [
		[(Delay forMilliseconds: 1) wait.  resultReceived] whileFalse.
		] notTakeMoreThanMilliseconds: 50.
	self should: resultReceived
]

{ #category : #tests }
ZeroMQTest >> testSocketOptions [
	|pair1 pair2 result|
	pair1 := self newPairSocket bind: 'inproc://#1'.
	pair2 := self newPairSocket connect: 'inproc://#1'.

	pair1 send: 'OK' asByteArray flags: ZmqApiConstants zmqSendMore.
	pair1 send: 'MK' asByteArray.
	result := pair2 receive.
	self assert: result asString = 'OK'.
	result:= pair2 getOption: ZmqApiConstants zmqRcvMore.
	Transcript show:result asString;cr.
	result := pair2 receive.
	self assert: result asString = 'MK'.
	result:= pair2 getOption: ZmqApiConstants zmqRcvMore.
	Transcript show:result asString;cr.
	self assert: result = 0.


	
]

{ #category : #tests }
ZeroMQTest >> testVersion [
	self assert: ZmqApi zmqVersion notNil description: 'Could not get version'.
	self assert: ZmqApi zmqVersion >= (ZmqVersion major: 2 minor: 1 patch: 7) description: 'This is developed for 2.1.7 version or higher'.
]
