Class {
	#name : #IPExecuteErrorMsg,
	#superclass : #IPMsg,
	#category : 'JupyterTalk-Messages-IOPub'
}

{ #category : #accessing }
IPExecuteErrorMsg >> msgType [
	^ #error
]
