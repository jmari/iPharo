Class {
	#name : #ZmqProxyTest,
	#superclass : #ZmqBaseTest,
	#category : #'ZeroMQ-Tests'
}

{ #category : #tests }
ZmqProxyTest >> testProxy [
	| frontend backend |
	frontend := ZmqRouterSocket new.
	frontend bind: 'tcp://*:5559'.
	backend := ZmqDealerSocket new.
	backend bind: 'tcp://*:5560'.
	ZmqProxy frontend: frontend backend: backend capture: nil
	"this freezes the image forever"

	
	
	
]

{ #category : #tests }
ZmqProxyTest >> testProxyPubSub [
	| frontend backend |
	frontend := ZmqXSubscriberSocket new.
	frontend bind: 'tcp://*:5559'.
	backend := ZmqXPublisherSocket new.
	backend bind: 'tcp://*:5560'.
	ZmqProxy frontend: frontend backend: backend capture: nil
	"this freezes the image forever, proxy process keep waiting for connections and message fordwarding"

	
	
	
]

{ #category : #tests }
ZmqProxyTest >> testPubSubTroughProxyDo [
	| publisher pr1 pr2 |
	publisher := ZmqPublisherSocket new connect: 'tcp://localhost:5559'.

	pr1 :=	[
		|subscriber1|	
		subscriber1 := ZmqSubscriberSocket new connect: 'tcp://localhost:5560'.
		[true] whileTrue:[ 
			subscriber1 receiveIfAvailable: [ :messageData|  
			messageData isEmpty ifFalse:[Transcript show: ('Subscriber 1 got stuff ' , messageData);cr]]
			]] forkNamed: 'subscriber1'.

	pr2 := 	[
		|subscriber2|	
		subscriber2 := ZmqSubscriberSocket new connect: 'tcp://localhost:5560'.	

		[true] whileTrue:[ 
			subscriber2 receiveIfAvailable: [ :messageData|  
			messageData isEmpty ifFalse:[Transcript show: ('Subscriber got stuff ' , messageData);cr]]
			]] forkNamed:'subscriber2'.

	1 to:10 do:[ :n | publisher send: ('Hello Subscribers for ', n asString, ' time') asByteArray ].
	
	(Delay forMilliseconds: 500) wait.
	pr1 terminate.
	pr2 terminate.
]

{ #category : #tests }
ZmqProxyTest >> testReqRepTroughProxyDo [
	| resultReceived req rep|
	resultReceived := false.

	req := self newReqSocket connect: 'tcp://localhost:5559'.
	rep := self newRepSocket connect: 'tcp://localhost:5560'.
	req
		withResultDo: [ 
			resultReceived := true.
			].
	rep
		withResultDo: [ :r | 
			Transcript show: 'got stuff ',r;cr.
			rep send: r asByteArray ].
	req send: 'viesti' asByteArray.
	self should: [
		[(Delay forMilliseconds: 1) wait.  resultReceived] whileFalse.
		] notTakeMoreThanMilliseconds: 50.
	self should: resultReceived

	
	
	
]
