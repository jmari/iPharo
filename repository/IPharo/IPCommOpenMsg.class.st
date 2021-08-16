Class {
	#name : #IPCommOpenMsg,
	#superclass : #IPCommMsg,
	#category : #'IPharo-Messages-Comm'
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
