Class {
	#name : #IPKernelInfoRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-KernelProxy-Messages-Shell'
}

{ #category : #initialization }
IPKernelInfoRequestMsg >> initialize [ 
	super initialize.
	self msgType: #kernel_info_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new.
]
