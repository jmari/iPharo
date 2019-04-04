Class {
	#name : #IPCommCloseMsg,
	#superclass : #IPCommMsg,
	#category : 'JupyterTalk-Messages-Comm'
}

{ #category : #accessing }
IPCommCloseMsg >> msgType [
	^ #comm_close
]
