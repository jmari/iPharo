Extension { #name : #DAPServer }

{ #category : #'*IPharo' }
DAPServer >> dapDebugInfo: aDAPDebugInfoRequest [
	<dap: #debugInfo>
	| debugInfo |

	debugInfo := (DAPDebugInfoResponse new
												seq: self nextSeq;
												request_seq: aDAPDebugInfoRequest seq;
												command: aDAPDebugInfoRequest command;
												yourself).
								
	debugInfo body at: #breakpoints put:self getAllBreakpoints.	
	debugInfo	 body at:#isStarted put: initialized.		
	self sendMessage: debugInfo
]

{ #category : #'*IPharo' }
DAPServer >> dapDumpCell: aDAPDumpCellRequest [
	<dap: #dumpCell>
	| code sourcePath fileReference ws|
	
	code := ((aDAPDumpCellRequest arguments) at:#code).
	fileReference := (self murmurFileNameForCode: code) asFileReference.  
	sourcePath := fileReference fullName.
	ws := fileReference writeStream.
	[ ws nextPutAll: code ] ensure:[ ws close ].
	sourcesReferenceCache at: 0 put: ({ #sourceCode -> code.
												  #path -> sourcePath } asSCJsonObject).

	self sendMessage: (DAPDumpCellResponse new 
									seq: self nextSeq;
									request_seq: aDAPDumpCellRequest seq;
									command: aDAPDumpCellRequest command;
									body:({ 'sourcePath'-> sourcePath } asDictionary);yourself)
]

{ #category : #'*IPharo' }
DAPServer >> dapInspectVariables: aDAPInspectVariablesRequest [
	<dap: #inspectVariables>
	| scope context2 variables|

	initialized :=true. 
	variables := OrderedCollection new.

	variablesReferenceCache keysDo:[ :aVariablesReference |
		
		scope := (variablesReferenceCache at: aVariablesReference) at: #scope.
		context2 := (variablesReferenceCache at: aVariablesReference) at: #context.
		variables := (scope getDAPVariablesInContent: context2) collect:[ :aVar |
		{
			#name->aVar name.
			#variableReference-> aVariablesReference.
			#value-> (aVar value1 asString).
			#type -> (aVar value1 class name).
		} asDictionary ] ].

	self sendMessage: (DAPInspectVariablesResponse new
												seq: self nextSeq;
												request_seq: aDAPInspectVariablesRequest seq;
												command: aDAPInspectVariablesRequest command;
												body: { #variables->variables asArray} asDictionary;
												yourself)
]

{ #category : #'*IPharo' }
DAPServer >> handleLaunch: source seq: seq [ 
	| result compiledMethod breakpointList sourceWithBreakpoints iPSession |

		'Launch.' record.	
		self threads at: 1 put: 1.
		strategy := OupsDebuggerSelectionStrategy debuggerSelectionStrategy.
		OupsDebuggerSelectionStrategy debuggerSelectionStrategy: (DAPOupsDebuggerSelector with: { self }).
		'Begin Evaluate.' record.		
		breakpointList := self breakpoints at: (self murmurFileNameForCode:source) ifAbsent: Array new. 
		sourceWithBreakpoints := self insertHaltsIn: source using:breakpointList.
		compiledMethod := self pluggableCompilationBlock value: sourceWithBreakpoints.
		iPSession :=self pluggableCompilationBlock receiver. 
		result:= compiledMethod  
			valueWithReceiver: iPSession 
			arguments:{iPSession}. 
		'End Evaluate.' record.
		OupsDebuggerSelectionStrategy debuggerSelectionStrategy: strategy.
		self sendMessage: DAPTerminatedEvent new. 
		"now its the time to publish the execution result"
		iPSession publishExecutionResult: result.


]

{ #category : #'*IPharo' }
DAPServer >> isInitialized [
	^ initialized

]

{ #category : #'*IPharo' }
DAPServer >> launch: source seq: seq [ 
	"jupyterLab only supports the code stack if you select other scope it gives an code 
	out of sync error...the offset is because the name of the method DoIt: inserted by Pharo"
	self 
		lineOffset: 0;
		numberOfStacks: 10.
	debugSession ifNotNil:[ debugSession resume ].
	self
		messageProcess: seq
		put:
			([ 
				self handleLaunch: source seq: seq.
				self removeMessageProcess: seq]
				forkNamed: 'IPharo debug process') 


]

{ #category : #'*IPharo' }
DAPServer >> murmurFileNameForCode: sourceCode [
	| hasher hash |
	hasher := NCHMurmur2 withSeed: 1972.
	hash :=  hasher hash: (sourceCode withLineEndings: String lf) asByteArray.
	^  '/tmp/', hash asString,'.st'
]

{ #category : #'*IPharo' }
DAPServer >> setCodeForFrameId: aFrameId [
	| stack scope |
	stack := self getStacks
		detect: [ :aStack | aStack hash = aFrameId ].
	scope := stack sourceNodeExecuted scope.
	(sourcesReferenceCache at: 0 ) sourceCode:stack method sourceCode.
]
