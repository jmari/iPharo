private
privateTerminate
	contextPointer
		ifNotNil: [ 
			self zmqApi terminateContextPointer: contextPointer.
			contextPointer := nil ]