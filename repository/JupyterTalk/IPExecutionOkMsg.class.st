Class {
	#name : #IPExecutionOkMsg,
	#superclass : #IPExecuteRequestReplayMsg,
	#category : 'JupyterTalk-Messages-Shell'
}

{ #category : #accessing }
IPExecutionOkMsg >> status [
	^ #ok
]
