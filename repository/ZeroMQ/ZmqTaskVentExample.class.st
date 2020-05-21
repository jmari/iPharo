Class {
	#name : #ZmqTaskVentExample,
	#superclass : #Object,
	#instVars : [
		'workers'
	],
	#category : #'ZeroMQ-Tests'
}

{ #category : #'instance creation' }
ZmqTaskVentExample >> newWorker [
	
	^ [|receiver sender data|
		receiver := self newPullSocket.
		receiver connect: 'tcp://localhost:5557'.
		sender := self newPushSocket.
		sender connect: 'tcp://localhost:5557'.
		[true] whileTrue:[
			data := receiver receive.
			sender send: data.
			Transcript show:('Waiting for:',data asString);crlf.
			Processor yield.
			(Delay forMilliseconds: (Integer newFrom: data) ) wait ]
	 ] fork
	
]

{ #category : #'as yet unclassified' }
ZmqTaskVentExample >> numberOfWorkers [
	^50
]

{ #category : #initialization }
ZmqTaskVentExample >> setUp [
	super setUp.
	workers := OrderedCollection new.
	1 to: self numberOfWorkers do:[:w|
		workers add: self newWorker.
	]	
]

{ #category : #tests }
ZmqTaskVentExample >> taskVent [
	| sender sink gen totalMilliseconds workLoad |
	sender := self newPushSocket.
	sender bind:'tcp://*:5557'.
	sink :=  self newPushSocket.
	sink connect: 'tcp://localhost:5558'.
	sink send:'0'asByteArray.
	gen := Random seed: 2000.
	totalMilliseconds := 0.
	workLoad := 0.
	0 to:self numberOfWorkers do:[:each|
		workLoad :=	(gen nextInt:100) + 1.
		totalMilliseconds := totalMilliseconds + workLoad.
		Transcript show:( totalMilliseconds asString); cr.
		sink send:workLoad asString asByteArray]
	
]

{ #category : #initialization }
ZmqTaskVentExample >> tearDown [ 

	workers do:[:w| w terminate].
	self closeSockets.
	"ZmqContext terminate."
]

{ #category : #tests }
ZmqTaskVentExample >> testTaskVent [
	| sender sink gen totalMilliseconds workLoad |
	sender := self newPushSocket.
	sender bind:'tcp://*:5557'.
	sink :=  self newPushSocket.
	sink connect: 'tcp://localhost:5558'.
	sink send:'0'asByteArray.
	gen := Random seed: 2000.
	totalMilliseconds := 0.
	workLoad := 0.
	0 to:self numberOfWorkers do:[:each|
		workLoad :=	(gen nextInt:100) + 1.
		totalMilliseconds := totalMilliseconds + workLoad.
		Transcript show:( totalMilliseconds asString); crlf.
		sink send:workLoad asString asByteArray]
	
]
