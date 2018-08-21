tests
testExcecuteRequest
	| sp result|
	sp := self shellProcessor.
	sp wireMessage: self wireMessage.
	result := sp execute: self wireMessage.
	self assert: (self session bindings at:#now ifAbsent:[nil]) notNil.
	self assert: ((self session bindings at:#now ) < DateAndTime now)