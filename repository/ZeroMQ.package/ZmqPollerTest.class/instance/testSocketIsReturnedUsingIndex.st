tests
testSocketIsReturnedUsingIndex
	| poller socket1 socket2 socket3 index1 index2 index3|
	poller := ZmqPoller onContext: ZmqContext current.
	socket1 := self newRepSocket.
	socket2 := self newReqSocket.
	socket3 := self newPullSocket.
	index1 := poller pollSocket: socket1 forEvents: ZmqPollIn.
	index2 := poller pollSocket: socket2 forEvents: ZmqPollIn.
	index3 := poller pollSocket: socket3 forEvents: ZmqPollIn.
	self assert: (poller socketAt: index1) equals: socket1.
	self assert: (poller socketAt: index2) equals: socket2.
	self assert: (poller socketAt: index3) equals: socket3.
	
	