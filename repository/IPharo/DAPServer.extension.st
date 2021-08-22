Extension { #name : #DAPServer }

{ #category : #'*IPharo' }
DAPServer >> dapDebugInfo: aDAPDumpCellRequest [
	<dap: #debugInfo>
	self sendMessage: DAPDebugInfoResponse new
]

{ #category : #'*IPharo' }
DAPServer >> dapDumpCell: aDAPDumpCellRequest [
	<dap: #dumpCell>
	
	self halt.
	self sendMessage: DAPDumpCellResponse new
]
