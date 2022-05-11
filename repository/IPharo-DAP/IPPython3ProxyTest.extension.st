Extension { #name : #IPPython3ProxyTest }

{ #category : #'*IPharo-DAP' }
IPPython3ProxyTest >> testDebugInfoRequest [
	| dapMsg debugInfoMessage |
	dapMsg := DAPDebugInfoRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	
]

{ #category : #'*IPharo-DAP' }
IPPython3ProxyTest >> testFullDebugSeqRequest [
	| dapMsg debugInfoMessage path stackFrame |
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
		#code-> self sourceCode} asDictionary .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert:  debugInfoMessage content body sourcePath notNil.
	path := debugInfoMessage content body sourcePath.
	dapMsg := DAPSetBreakpointsRequest new.
	dapMsg arguments:{
		#source ->{
			#path-> path.
		} asDictionary.
		#breakpoints ->{{#line->1} asDictionary} } asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	dapMsg := DAPConfigurationDoneRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	
	
	debugInfoMessage := kernelProxy executeRequest: self sourceCode.
	self assert:  debugInfoMessage content status equals:#ok.

	"inspect variables two times....behaviour of jupyterLab is so strange"
	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.

	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.

	dapMsg := DAPStackTraceRequest new arguments: {#threadId->1} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	self assert: debugInfoMessage content success equals: true.
	stackFrame := debugInfoMessage content body stackFrames first id.

	dapMsg := DAPSourceRequest new arguments: 
	{#sourceReference->0. 
	 #source->{
		"jupyterLab always ask for sourceReference 0 so that the only way to recover the correct source block is waiting for the next call scope"
		#path-> path
		} asSCJsonObject 
	} asSCJsonObject .
	
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	dapMsg := DAPScopesRequest new arguments:  {#frameId->stackFrame} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	dapMsg := DAPStepOutRequest  new arguments:  {#threadId->0} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.

	dapMsg := DAPSourceRequest new arguments: 
	{#sourceReference->0. 
	#source->{
		#path-> path
		} asSCJsonObject 
	} asSCJsonObject.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	dapMsg := DAPDisconnectResquest  new .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	
	(Delay forMilliseconds: 3000) wait
		
	

]
