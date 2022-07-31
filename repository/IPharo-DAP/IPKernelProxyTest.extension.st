Extension { #name : #IPKernelProxyTest }

{ #category : #'*IPharo-DAP' }
IPKernelProxyTest >> testDebugInfoRequest [
	| dapMsg  response |
	dapMsg := DAPDebugInfoRequest new.
	kernelProxy 
		onDebugReplyDo: [ :msg | response := msg ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:100) wait].
	self assert: response content success equals: true.
	
]

{ #category : #'*IPharo-DAP' }
IPKernelProxyTest >> testFullDebugSeqRequest [
	| dapMsg debugInfoMessage path stackFrame response |
	response := nil.
	dapMsg := DAPDebugInfoRequest new.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	response := nil.
	dapMsg := DAPInitializeRequest new.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	response := nil.
	dapMsg := DAPAttachRequest new.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	
	"inspect variables will start the DAP server"
	response := nil.
	dapMsg := DAPInspectVariablesRequest new.
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------"
	response := nil.
	dapMsg := DAPDumpCellRequest new.
	dapMsg arguments:{
		#code-> self sourceCode} asDictionary .
	debugInfoMessage := kernelProxy debugRequest: dapMsg.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].

	self assert:  response content body sourcePath notNil.

	"------------------------------"
	response := nil.
	path := response content body sourcePath.
	dapMsg := DAPSetBreakpointsRequest new.
	dapMsg arguments:{
		#source ->{
			#path-> path.
		} asDictionary.
		#breakpoints ->{{#line->1} asDictionary} } asDictionary.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	"-------------------------------------------------"
	response:=nil.	
	dapMsg := DAPConfigurationDoneRequest new.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------------------------"
	response:=nil.	
		
	kernelProxy 
		onDebugEventPublishedDo: [:r | response := r ];
		executeRequest: self sourceCode.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert:  response content event equals:#stopped.
	"-------------------------------------------------"
	response:=nil.	
	"inspect variables two times....behaviour of jupyterLab is so strange"
	dapMsg := DAPInspectVariablesRequest new.
		kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------------------------"
	response:=nil.	
	dapMsg := DAPInspectVariablesRequest new.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	"-------------------------------------------------"
	response:=nil.	
	dapMsg := DAPStackTraceRequest new arguments: {#threadId->1} asDictionary.
	
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	self assert: response content success equals: true.
	stackFrame := response content body stackFrames first id.
	
	"-------------------------------------------------"
	response:=nil.	
	dapMsg := DAPSourceRequest new arguments: 
	{#sourceReference->0. 
	 #source->{
		"jupyterLab always ask for sourceReference 0 so that the only way to recover the correct source block is waiting for the next call scope"
		#path-> path
		} asSCJsonObject 
	} asSCJsonObject .
	
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	"----------------------------------------------"
	response:=nil.	
	dapMsg := DAPScopesRequest new arguments:  {#frameId->stackFrame} asDictionary.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	"-------------------------------------------"
	response:=nil.	
	dapMsg := DAPStepOutRequest  new arguments:  {#threadId->0} asDictionary.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	"------------------------------------------"
	response:=nil.	
	dapMsg := DAPSourceRequest new arguments: 
	{#sourceReference->0. 
	#source->{
		#path-> path
		} asSCJsonObject 
	} asSCJsonObject.
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].
	"----------------------------------"
	response:=nil.	
	dapMsg := DAPDisconnectResquest  new .
	kernelProxy 
		onDebugReplyDo: [:r | response := r ];
		debugRequest: dapMsg.
	[ response isNil ] whileTrue: [(Delay forMilliseconds:50) wait].

]
