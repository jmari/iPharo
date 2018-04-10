comm handlers
commMsgHandlersFor: commID
	^ self commMsgHandlers at:commID ifAbsent:[Array new]