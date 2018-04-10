as yet unclassified
socketPointer
	monitor
		critical: [ 
			self waitForUnpark.
			^ socketPointer ifNil: [ socketPointer := self newSocketPointer ] ]