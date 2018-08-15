tests
testPollerWhenNoEvents
	| poller req |
	poller := ZmqPoller onContext: ZmqContext current.
	req := self newReqSocket.
	poller pollSocket: req forEvents: ZmqPollIn.
	self assert: (poller pollFor: 1 milliSeconds) equals: 0.
	