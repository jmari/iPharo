Class {
	#name : #IPExecutionAbortedMsg,
	#superclass : #IPExecuteRequestReplayMsg,
	#category : 'JupyterTalk-Messages-Shell'
}

{ #category : #accessing }
IPExecutionAbortedMsg >> status [
	^ #abort
]
