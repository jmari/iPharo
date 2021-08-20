Class {
	#name : #IPCommOpenMsg,
	#superclass : #IPCommMsg,
	#category : #'IPharo-Messages-Custom'
}

{ #category : #initialization }
IPCommOpenMsg >> initialize [
	super initialize.
	self metadata at:#version put: IPComm version
	
]

{ #category : #accessing }
IPCommOpenMsg >> msgType [
	^ #comm_open
]
