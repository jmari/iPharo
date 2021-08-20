Class {
	#name : #IPCommCloseMsg,
	#superclass : #IPCommMsg,
	#category : #'IPharo-Messages-Custom'
}

{ #category : #accessing }
IPCommCloseMsg >> msgType [
	^ #comm_close
]
