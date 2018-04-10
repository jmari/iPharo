tests
testSocketOptions
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


	