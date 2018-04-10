as yet unclassified
startPolling
	pollerProcess ifNotNil: [ Error signal: 'Poller already started!' ].
	pollerProcess := [ 
	[ 
	[ 
	self poll > 0
		ifFalse: [ self giveOtherThreadsTimeToRun ].
	self socketsCount > 0 ] whileTrue ]
		ensure: [ pollerProcess := nil ] ] forkAt: Processor highIOPriority.
	pollerProcess name: 'Zmq Poller'