Class {
	#name : #IPDebugRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Control'
}

{ #category : #initialization }
IPDebugRequestMsg >> initialize [
	super initialize.
	self msgType: #debug_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new. 
]
