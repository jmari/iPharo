as yet unclassified
testBetween
	self assert: ((ZmqVersion fromString: '0.5.0') between: '0.5.0' and: '1.1.0').
	self assert: ((ZmqVersion fromString: '1.0.0') between: '0.5.0' and: '1.1.0').
	self assert: ((ZmqVersion fromString: '1.1.0') between: '0.5.0' and: '1.1.0').