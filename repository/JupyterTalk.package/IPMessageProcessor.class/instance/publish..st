comm handlers
publish: aResult
	| iopub |
	iopub := (IPharoKernel instance processors at:#iopub ifAbsent:[nil]). 
	iopub 
			ifNil:[ self debug: aResult asString ]
			ifNotNil:[ iopub publish:  aResult ]