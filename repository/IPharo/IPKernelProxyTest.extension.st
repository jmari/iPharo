Extension { #name : #IPKernelProxyTest }

{ #category : #'*IPharo' }
IPKernelProxyTest >> testDebugInfoRequest [
	| dapMsg debugInfoMessage |
	dapMsg := DAPDebugInfoRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	
]

{ #category : #'*IPharo' }
IPKernelProxyTest >> testFullDebugSeqRequest [
	| dapMsg debugInfoMessage |
	dapMsg := DAPDebugInfoRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	dapMsg := DAPInitializeRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	dapMsg := DAPAttachRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	dapMsg := DAPDumpCellRequest new.
	dapMsg arguments:{
		#code->'a:=1.
		b:=2'} asDictionary .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert:  debugInfoMessage content body sourcePath notNil.
	
	dapMsg := DAPSetBreakpointsRequest new.
	dapMsg arguments:{
		#source ->{
			#path->debugInfoMessage content body sourcePath.
		} asDictionary.
		#breakpoints ->{{#line->2} asDictionary} } asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert:  debugInfoMessage content body breakpoints notEmpty.
	debugInfoMessage := kernelProxy executeRequest: 'a:=1.
		b:=2'.
	self flag:#todo."it's not correct it should stop the execution"
	self assert:  debugInfoMessage content status equals:#ok.
		
]
