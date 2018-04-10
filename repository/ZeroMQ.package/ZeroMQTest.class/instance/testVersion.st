tests
testVersion
	self assert: ZmqApi zmqVersion notNil description: 'Could not get version'.
	self assert: ZmqApi zmqVersion >= (ZmqVersion major: 2 minor: 1 patch: 7) description: 'This is developed for 2.1.7 version or higher'.