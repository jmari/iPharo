tests
testPollerEvents
	| poller socket1 socket2 |
	poller := ZmqPoller onContext: ZmqContext current.
	socket1 := self newReqSocket.
	socket2 := self newRepSocket.
	socket1 bind: 'inproc://#1'.
	socket2 connect: 'inproc://#1'.
	poller pollSocket: socket1 forEvents: ZmqPollIn , ZmqPollOut.
	poller pollSocket: socket2 forEvents: ZmqPollIn , ZmqPollOut.
	poller
		pollFor: 1 milliSeconds
		withEventsAndSocketsDo: [ :events :socket | 
			self assert: socket equals: socket1.
			self assert: events isPollOut.
			socket send: 'message' asByteArray ].
	poller
		pollFor: 1 milliSeconds
		withEventsAndSocketsDo: [ :events :socket | 
			self assert: socket equals: socket2.
			self assert: events isPollIn ]