Class {
	#name : #IPCommCloseMsg,
	#superclass : #IPCommMsg,
	#category : #'IPharo-Messages-Comm'
}

{ #category : #accessing }
IPCommCloseMsg >> msgType [
	^ #comm_close
]
