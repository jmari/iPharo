accessing
msgUUID
 	^ msgUUID ifNil:[ UUID new hex asString asUppercase].