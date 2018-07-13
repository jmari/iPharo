comm handlers
msgHandler

	^ commMsgHandlers ifNil:[ commMsgHandlers := Dictionary new]