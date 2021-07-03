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
	"this freezes the image forever"

	
	
	
]
