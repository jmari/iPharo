Class {
	#name : #IPInterruptRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Control'
}

{ #category : #initialization }
IPInterruptRequestMsg >> initialize [
	super initialize.
	self msgType: #interrupt_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new. 
]
