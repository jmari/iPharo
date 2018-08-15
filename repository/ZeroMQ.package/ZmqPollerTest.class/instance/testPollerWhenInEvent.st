tests
testPollerWhenInEvent
	| poller req rep |
	poller := ZmqPoller onContext: ZmqContext current.
	rep := self newRepSocket.
	req := self newReqSocket.
	rep bind: 'inproc://#1'.	
	req connect: 'inproc://#1'.
	req send: 'request' asByteArray.
	poller pollSocket: rep forEvents: ZmqPollIn.
	self assert: (poller pollFor: 1 milliSeconds) equals: 1.
	