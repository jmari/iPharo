Class {
	#name : #DAPDumpCellRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-DAP-Messages-DAPSupport'
}

{ #category : #initialization }
DAPDumpCellRequest >> initialize [
	super initialize.
	command := 'dumpCell'
]
