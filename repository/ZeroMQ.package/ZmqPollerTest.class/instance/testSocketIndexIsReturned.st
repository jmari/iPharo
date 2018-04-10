as yet unclassified
testSocketIndexIsReturned
	| poller socket1 socket2 socket3 index1 index2 index3|
	poller := ZmqPoller new.
	socket1 := self newRepSocket.
	socket2 := self newReqSocket.
	socket3 := self newPullSocket.
	index1 := poller pollSocket: socket1 forEvents: ZmqPollIn.
	index2 := poller pollSocket: socket2 forEvents: ZmqPollIn.
	index3 := poller pollSocket: socket3 forEvents: ZmqPollIn.
	self assert: index1 equals: 1.
	self assert: index2 equals: 2.
	self assert: index3 equals: 3.
	