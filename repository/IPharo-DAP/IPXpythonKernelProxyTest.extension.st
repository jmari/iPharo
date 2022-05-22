Extension { #name : #IPXpythonKernelProxyTest }

{ #category : #'*IPharo-DAP' }
IPXpythonKernelProxyTest >> testDebugInfoRequest [
	| dapMsg debugInfoMessage response |
	dapMsg := DAPDebugInfoRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	
	
	self assert: response content success equals: true.
	
]

{ #category : #'*IPharo-DAP' }
IPXpythonKernelProxyTest >> testFullDebugSeqRequest [
	| dapMsg debugInfoMessage path stackFrame response |
	dapMsg := DAPDebugInfoRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	dapMsg := DAPInitializeRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	dapMsg := DAPAttachRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	
	"inspect variables will start the DAP server"
	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	
	dapMsg := DAPDumpCellRequest new.
	dapMsg arguments:{
		#code-> self sourceCode} asDictionary .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert:  response content body sourcePath notNil.

	"------------------------------"
	path := response content body sourcePath.
	dapMsg := DAPSetBreakpointsRequest new.
	dapMsg arguments:{
		#source ->{
			#path-> path.
		} asDictionary.
		#breakpoints ->{{#line->1} asDictionary} } asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].

	
	dapMsg := DAPConfigurationDoneRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------------------------"
	response:=nil.	
	debugInfoMessage := kernelProxy executeRequest: self sourceCode.

	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert:  response content event equals:#stopped.

	"inspect variables two times....behaviour of jupyterLab is so strange"
	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.

	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.

	dapMsg := DAPStackTraceRequest new arguments: {#threadId->1} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].

	self assert: response content success equals: true.
	stackFrame := response content body stackFrames first id.

	dapMsg := DAPSourceRequest new arguments: 
	{#sourceReference->0. 
	 #source->{
		"jupyterLab always ask for sourceReference 0 so that the only way to recover the correct source block is waiting for the next call scope"
		#path-> path
		} asSCJsonObject 
	} asSCJsonObject .
	
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
			
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	"----------------------------------------------"
	dapMsg := DAPScopesRequest new arguments:  {#frameId->stackFrame} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
			
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	"-------------------------------------------"
	dapMsg := DAPStepOutRequest  new arguments:  {#threadId->0} asDictionary.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
			
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	"------------------------------------------"
	dapMsg := DAPSourceRequest new arguments: 
	{#sourceReference->0. 
	#source->{
		#path-> path
		} asSCJsonObject 
	} asSCJsonObject.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
			
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	"----------------------------------"
	dapMsg := DAPDisconnectResquest  new .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
		
	debugInfoMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ debugInfoMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
		
	

]
