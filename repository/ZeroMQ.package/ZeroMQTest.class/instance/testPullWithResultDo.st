tests
testPullWithResultDo
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
