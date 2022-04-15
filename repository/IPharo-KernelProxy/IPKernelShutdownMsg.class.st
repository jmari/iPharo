Class {
	#name : #IPKernelShutdownMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-KernelProxy-Messages-Control'
}

{ #category : #initialization }
IPKernelShutdownMsg >> initialize [
	super initialize.
	self msgType: #shutdown_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: content = {
    	'restart' -> false } asSCJsonObject 

]

{ #category : #starting }
IPKernelShutdownMsg >> restart [
	self content at:#restart put: true
]
