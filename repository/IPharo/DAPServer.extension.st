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
	
	self sendMessage: (DAPDumpCellResponse new 
									seq: self nextSeq;
									request_seq: aDAPDumpCellRequest seq;
									command: aDAPDumpCellRequest command;
									body:({ 'sourcePath'-> sourcePath } asDictionary);yourself)
]

{ #category : #'*IPharo' }
DAPServer >> dapInspectVariables: aDAPInspectVariablesRequest [
	<dap: #inspectVariables>
	| variables |

	variables := variablesReferenceCache collect:[ :aVar | 
		{
			#name->aVar name.
			#variableReference-> aVar variablesReference.
			#value-> aVar value1.
			#type -> aVar class asString.
		} asDictionary
		].

	self sendMessage: (DAPInspectVariablesResponse new
												seq: self nextSeq;
												request_seq: aDAPInspectVariablesRequest seq;
												command: aDAPInspectVariablesRequest command;
												body: variables asArray;
												yourself)
]
