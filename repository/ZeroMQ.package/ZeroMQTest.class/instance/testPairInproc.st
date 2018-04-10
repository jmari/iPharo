tests
testPairInproc
	|pair1 pair2 result|
	pair1 := self newPairSocket bind: 'inproc://#1'.
	pair2 := self newPairSocket connect: 'inproc://#1'.
	pair1 send: 'OK' asByteArray.
	result := pair2 receive.

	self assert: result asString = 'OK'.
	