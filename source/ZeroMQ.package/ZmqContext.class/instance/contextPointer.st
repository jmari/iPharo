accessing
contextPointer
	^contextPointer ifNil: [ contextPointer := self zmqApi newContextPointer ]