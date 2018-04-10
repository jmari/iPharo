accessing
uuid
	^ wireMessage at:1 ifAbsent:[ByteArray new]