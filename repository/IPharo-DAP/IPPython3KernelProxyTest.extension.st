Extension { #name : #IPPython3KernelProxyTest }

{ #category : #'*IPharo-DAP' }
IPPython3KernelProxyTest >> testDebugInfoRequest [
	| dapMsg response |
	dapMsg := DAPDebugInfoRequest new.
	response := kernelProxy debugRequest: dapMsg.
	"doest support debugger"
	self assert: response  equals: nil.
	
]
