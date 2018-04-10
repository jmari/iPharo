accessing
getOption: option 
	|opt|
	monitor 
		critical: [ opt:= self zmqApi getSocketOption: option forSocket: self socketPointer].
	^ opt