Class {
	#name : #DAPDumpCellRequest,
	#superclass : #DAPRequest,
	#category : #'IPharo-Messages-DAPSupport'
}

{ #category : #initialization }
DAPDumpCellRequest >> initialize [
	super initialize.
	command := 'dumpCell'
]
