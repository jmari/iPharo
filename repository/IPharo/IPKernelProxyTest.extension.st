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
	| dapMsg debugInfoMessage path |
	dapMsg := DAPDebugInfoRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	dapMsg := DAPInitializeRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	dapMsg := DAPAttachRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	"inspect variables will start the DAP server"
	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	
	dapMsg := DAPDumpCellRequest new.
	dapMsg arguments:{
		#code->'a:=1.
		b:=2'} asDictionary .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert:  debugInfoMessage content body sourcePath notNil.
	path := #path->debugInfoMessage content body sourcePath.
	dapMsg := DAPSetBreakpointsRequest new.
	dapMsg arguments:{
		#source ->{
			#path->debugInfoMessage content body sourcePath.
		} asDictionary.
		#breakpoints ->{{#line->1} asDictionary} } asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	dapMsg := DAPConfigurationDoneRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	
	
	debugInfoMessage := kernelProxy executeRequest: 'a:=1.
		b:=2'.
	debugInfoMessage inspect.
	self assert:  debugInfoMessage content status equals:#ok.

	"inspect variables two times....behaviour of jupyterLab is so strange"
	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	debugInfoMessage inspect.
	self assert: debugInfoMessage content success equals: true.

	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	debugInfoMessage inspect.
	self assert: debugInfoMessage content success equals: true.

	dapMsg := DAPStackTraceRequest new arguments: {#threadId->1} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.

	dapMsg := DAPSourceRequest new arguments: 
	{#source->{
		#sourceReference->0.
		#path-> path
		} asDictionary
	} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	
	debugInfoMessage inspect.
	(Delay forMilliseconds: 3000) wait 
		
	

]
