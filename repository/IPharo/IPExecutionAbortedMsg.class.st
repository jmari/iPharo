Class {
	#name : #IPExecutionAbortedMsg,
	#superclass : #IPExecuteRequestReplyMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #accessing }
IPExecutionAbortedMsg >> status [
	^ #abort
]
