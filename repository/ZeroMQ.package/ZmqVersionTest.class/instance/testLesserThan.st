as yet unclassified
testLesserThan
	self assert: (ZmqVersion fromString:'2.2.1') < (ZmqVersion fromString:'2.2.2').
	self assert: (ZmqVersion fromString:'2.1.2') < (ZmqVersion fromString:'2.2.2').
	self assert: (ZmqVersion fromString:'1.2.2') < (ZmqVersion fromString:'2.2.2').

