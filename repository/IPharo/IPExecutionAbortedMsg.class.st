Class {
	#name : #IPExecutionAbortedMsg,
	#superclass : #IPExecuteRequestReplayMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #accessing }
IPExecutionAbortedMsg >> status [
	^ #abort
]
