Extension { #name : #IPXpythonKernelProxyTest }

{ #category : #'*IPharo-DAP' }
IPXpythonKernelProxyTest >> testDebugInfoRequest [
	| dapMsg response |
	dapMsg := DAPDebugInfoRequest new.
	response := kernelProxy debugRequest: dapMsg.
	
	self assert: response  equals: nil.
	
]
