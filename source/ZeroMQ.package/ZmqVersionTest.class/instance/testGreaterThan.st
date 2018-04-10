as yet unclassified
testGreaterThan
	self assert: (ZmqVersion fromString:'1.2.3') > (ZmqVersion fromString:'1.2.2').
	self assert: (ZmqVersion fromString:'1.2.3') > (ZmqVersion fromString:'1.1.3').
	self assert: (ZmqVersion fromString:'1.2.3') > (ZmqVersion fromString:'0.2.4').

