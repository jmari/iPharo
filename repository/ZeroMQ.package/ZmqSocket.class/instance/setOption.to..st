accessing
setOption: option to:aValue
	|opt|
	monitor 
		critical: [ opt:= self zmqApi setSocketOption: option forSocket: self socketPointer to:aValue].
	