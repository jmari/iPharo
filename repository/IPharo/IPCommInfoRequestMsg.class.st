Class {
	#name : #IPCommInfoRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPCommInfoRequestMsg >> initialize [
	super initialize.
	self msgType: #comm_info_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new. 

]
