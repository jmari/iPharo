Class {
	#name : #IPCommListener,
	#superclass : #Object,
	#category : #'IPharo-Widgets'
}

{ #category : #'comm-listener' }
IPCommListener >> onDataReceived: data [
	self subclassResponsibility 
]
