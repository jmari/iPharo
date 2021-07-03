Class {
	#name : #ZmqProxy,
	#superclass : #Object,
	#category : #'ZeroMQ-Core'
}

{ #category : #'as yet unclassified' }
ZmqProxy class >> frontend: frontEndSocket backend: backendSocket capture: captureSocket [

	Zmq4Api apiZmqProxyFrontEnd: frontEndSocket socketPointer backEnd: backendSocket socketPointer 
	capture: (captureSocket 
	ifNil:[ nil ]
	ifNotNil: [captureSocket socketPointer])

]
