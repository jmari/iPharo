as yet unclassified
privateClose
	monitor
		critical: [ 
			socketPointer
				ifNotNil: [ 
					ZmqApi closeSocket: socketPointer.
					socketPointer := nil.] ]