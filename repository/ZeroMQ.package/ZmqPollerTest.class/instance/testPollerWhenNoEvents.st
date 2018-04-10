as yet unclassified
testPollerWhenNoEvents
	| poller req |
	poller := ZmqPoller new.
	req := self newReqSocket.
	poller pollSocket: req forEvents: ZmqPollIn.
	self assert: (poller pollFor: 1 milliSeconds) equals: 0.
	