as yet unclassified
testEqualityNegativeCase
	self deny: (ZmqVersion fromString:'1.2.3') = (ZmqVersion fromString:'1.2.4').