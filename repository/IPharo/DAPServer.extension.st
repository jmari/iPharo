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
	| code sourcePath fileReference ws |

	code := ((aDAPDumpCellRequest arguments) at:#code).
	fileReference := ('/tmp/dc', code hash asString ,'.st') asFileReference.  
	sourcePath := fileReference fullName.
	ws := fileReference writeStream.
	[ ws nextPutAll: code ] ensure:[ ws close ].
	sourcesReferenceCache at: 0 put: ({ #sourceCode -> code} asSCJsonObject).
	sourcesReferenceCache inspect.
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
	| strategy result|

	[	'Launch.' record.	
		self threads at: 1 put: 1.
		strategy := OupsDebuggerSelectionStrategy debuggerSelectionStrategy.
		OupsDebuggerSelectionStrategy debuggerSelectionStrategy: (DAPOupsDebuggerSelector with: { self }).
		'Begin Evaluate.' record.		
		sourcesReferenceCache at: 0 put: { #sourceCode -> source} asSCJsonObject.
		result := self pluggableEvaluationBlock value: source.
		'End Evaluate.' record.
		OupsDebuggerSelectionStrategy debuggerSelectionStrategy: strategy]
	on: Error do: [ :dapError | dapError pass ];
	ensure:[ OupsDebuggerSelectionStrategy debuggerSelectionStrategy: strategy ].
	
				
	^ result

]

{ #category : #'*IPharo' }
DAPServer >> isInitialized [
	^ initialized

]

{ #category : #'*IPharo' }
DAPServer >> launch: source seq: seq [ 

	self
		messageProcess: seq
		put:
			([ self handleLaunch: source seq: seq.
				Processor yield.
				(Delay forMilliseconds: 500) wait.
			self removeMessageProcess: seq ]
				forkAt: Processor lowIOPriority
				named: 'IPharo debug process')

]
