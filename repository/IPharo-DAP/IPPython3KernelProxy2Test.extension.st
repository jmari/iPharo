Extension { #name : #IPPython3KernelProxy2Test }

{ #category : #'*IPharo-DAP' }
IPPython3KernelProxy2Test >> testDebugInfoRequest [
	| dapMsg  response |
	dapMsg := DAPDebugInfoRequest new.
	kernelProxy 
		onDebugReplyDo: [ :msg | response := msg ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].
	self assert: response content success equals: true.
	
]
