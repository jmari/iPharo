accessing
uuid
	^ uuid ifNil:[ uuid:= UUID new hex asString asUppercase].