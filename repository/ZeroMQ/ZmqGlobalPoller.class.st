Class {
	#name : #ZmqGlobalPoller,
	#superclass : #ZmqResource,
	#instVars : [
		'pollerProcess',
		'poller'
	],
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> ensurePollerRuns [
	pollerProcess ifNil: [ self startPolling ]
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> giveOtherThreadsTimeToRun [
	^ (Delay forMilliseconds: 1) wait
]

{ #category : #initialization }
ZmqGlobalPoller >> initialize [
	super initialize.
	poller := ZmqPoller onContext: self context.
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> poll [
	^ self poller pollEventsAndSocketsDo: [ :events :socket | events ifReadEvent: [ socket dataAvailable ] ]
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> pollInSocket: aZmqSocket [
	poller pollSocket: aZmqSocket forEvents: ZmqPollIn.
	self ensurePollerRuns.
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> poller [
	^ poller ifNil:[poller := ZmqPoller new].
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> removeSocket: aZmqSocket [
	poller removeSocket: aZmqSocket
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> socketsCount [
	^ self poller size.
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> startPolling [
	pollerProcess ifNotNil: [ Error signal: 'Poller already started!' ].
	pollerProcess := [ 
	[ 
	[ 
	self poll > 0
		ifFalse: [ self giveOtherThreadsTimeToRun ].
	self socketsCount > 0 ] whileTrue ]
		ensure: [ pollerProcess := nil ] ] forkAt: Processor highIOPriority.
	pollerProcess name: 'Zmq Poller'
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> stopPolling [
	pollerProcess ifNotNil: [ pollerProcess terminate ]
]

{ #category : #'as yet unclassified' }
ZmqGlobalPoller >> zmqApi [
	^ self context zmqApi.
]
