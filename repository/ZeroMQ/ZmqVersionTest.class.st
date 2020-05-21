Class {
	#name : #ZmqVersionTest,
	#superclass : #TestCase,
	#category : #'ZeroMQ-Tests'
}

{ #category : #'as yet unclassified' }
ZmqVersionTest >> testBetween [
	self assert: ((ZmqVersion fromString: '0.5.0') between: '0.5.0' and: '1.1.0').
	self assert: ((ZmqVersion fromString: '1.0.0') between: '0.5.0' and: '1.1.0').
	self assert: ((ZmqVersion fromString: '1.1.0') between: '0.5.0' and: '1.1.0').
]

{ #category : #'as yet unclassified' }
ZmqVersionTest >> testEquality [
	self assert: (ZmqVersion fromString:'1.2.3') = (ZmqVersion fromString:'1.2.3').
]

{ #category : #'as yet unclassified' }
ZmqVersionTest >> testEqualityNegativeCase [
	self deny: (ZmqVersion fromString:'1.2.3') = (ZmqVersion fromString:'1.2.4').
]

{ #category : #'as yet unclassified' }
ZmqVersionTest >> testGreaterThan [
	self assert: (ZmqVersion fromString:'1.2.3') > (ZmqVersion fromString:'1.2.2').
	self assert: (ZmqVersion fromString:'1.2.3') > (ZmqVersion fromString:'1.1.3').
	self assert: (ZmqVersion fromString:'1.2.3') > (ZmqVersion fromString:'0.2.4').


]

{ #category : #'as yet unclassified' }
ZmqVersionTest >> testLesserThan [
	self assert: (ZmqVersion fromString:'2.2.1') < (ZmqVersion fromString:'2.2.2').
	self assert: (ZmqVersion fromString:'2.1.2') < (ZmqVersion fromString:'2.2.2').
	self assert: (ZmqVersion fromString:'1.2.2') < (ZmqVersion fromString:'2.2.2').


]

{ #category : #'as yet unclassified' }
ZmqVersionTest >> testPrinting [
	self assert: (ZmqVersion major:2 minor: 3 patch: 4) asString = '2.3.4'.
]
