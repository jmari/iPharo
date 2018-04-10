as yet unclassified
createSocketCreationMethodToContext
	(self class methodDict at: #socketType) isAbstract
		ifFalse: [ 
			ZmqContext
				compileSilently: self name asString uncapitalized  , '^ self newSocket:' , self name asString
				classified: #'socket creation'
				notifying: nil ]