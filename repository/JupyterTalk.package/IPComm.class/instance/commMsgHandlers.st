accessing
commMsgHandlers
	^ commMsgHandlers ifNil:[ commMsgHandlers:= OrderedCollection new]