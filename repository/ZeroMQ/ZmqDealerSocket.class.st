Class {
	#name : #ZmqDealerSocket,
	#superclass : #ZmqSocket,
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqDealerSocket class >> socketType [
	^ZmqApiConstants zmqDealer
]

{ #category : #'as yet unclassified' }
ZmqDealerSocket >> needsPoller [ 
	  ^ true
]

{ #category : #'as yet unclassified' }
ZmqDealerSocket >> socketTypeName [
	^'DEALER'
]
