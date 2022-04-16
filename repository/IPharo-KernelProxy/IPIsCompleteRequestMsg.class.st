Class {
	#name : #IPIsCompleteRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-KernelProxy-Messages-Shell'
}

{ #category : #initialization }
IPIsCompleteRequestMsg >> initialize [
	super initialize.
	self msgType: #is_complete_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: { #code ->''} asSCJsonObject.

]
