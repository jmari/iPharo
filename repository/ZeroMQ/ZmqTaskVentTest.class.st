Class {
	#name : #ZmqTaskVentTest,
	#superclass : #Object,
	#instVars : [
		'workers',
		'createdSockets'
	],
	#category : 'ZeroMQ-Tests'
}

{ #category : #convenience }
ZmqTaskVentTest >> closeSockets [
	createdSockets do:[:zmqSocket | zmqSocket close].
]

{ #category : #'instance creation' }
ZmqTaskVentTest >> newPullSocket [
	^createdSockets add: ZmqPullSocket new.
]

{ #category : #'instance creation' }
ZmqTaskVentTest >> newPushSocket [
	^createdSockets add: ZmqPushSocket new.
]

{ #category : #'instance creation' }
ZmqTaskVentTest >> newWorker [
	
	^ [|receiver sender data run|
		run := true.
		receiver := self newPullSocket.
		receiver connect: 'tcp://localhost:5557'.
		sender := self newPushSocket.
		sender connect: 'tcp://localhost:5558'.
		[run] whileTrue:[
			data := receiver receive.
			data isEmpty 
						ifTrue:[
							Processor yield]
						ifFalse:[
							Transcript show:('Rec:',data asString);cr.
							sender send: data asByteArray.
							Transcript show:('Waiting for:',data asString);cr.
							Processor yield.
							(Delay forMilliseconds: (Integer readFrom: data asString) ) wait]]
						
	 ] fork
	
]

{ #category : #'as yet unclassified' }
ZmqTaskVentTest >> numberOfWorkers [
	^50
]

{ #category : #initialization }
ZmqTaskVentTest >> setUp [
	ZmqContext current.
	createdSockets := OrderedCollection new.

]

{ #category : #initialization }
ZmqTaskVentTest >> startWorkers [
	workers := OrderedCollection new.
	1 to: self numberOfWorkers do:[:w|
		workers add: self newWorker.
	]	

]

{ #category : #running }
ZmqTaskVentTest >> tearDown [ 

	workers do:[:w| w terminate].
	workers :=OrderedCollection new.
	self closeSockets.
	"ZmqContext terminate."
]

{ #category : #tests }
ZmqTaskVentTest >> testTaskVent [
	| sender sink gen totalMilliseconds workLoad |
	self setUp.
	sender := self newPushSocket.
	sender bind:'tcp://*:5557'.
	sink :=  self newPushSocket.
	sink connect: 'tcp://localhost:5558'.
	sink send:'0'asByteArray.
	gen := Random seed: 2000.
	totalMilliseconds := 0.
	workLoad := 0.
	self startWorkers.
	(Delay forMilliseconds: 3000) wait.
	0 to:self numberOfWorkers do:[:each|
		workLoad :=	(gen nextInt:100) + 1.
		totalMilliseconds := totalMilliseconds + workLoad.
		Transcript show:( totalMilliseconds asString); cr.
		sender send:workLoad asString asByteArray].

]
