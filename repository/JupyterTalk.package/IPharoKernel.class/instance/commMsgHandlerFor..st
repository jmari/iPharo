comm handlers
commMsgHandlerFor: commID
	^ self commMsgHandlers at:commID ifAbsent:[Array new]