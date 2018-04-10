tests
testReqRepWithResultDo
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