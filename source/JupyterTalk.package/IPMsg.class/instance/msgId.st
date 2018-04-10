accessing
msgId
	^ msg_id ifNil:[ msg_id:= UUID new hex asString asUppercase].