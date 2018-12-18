accessing
commListeners
	^ commMsgListener ifNil:[ commMsgListener:= OrderedCollection new]