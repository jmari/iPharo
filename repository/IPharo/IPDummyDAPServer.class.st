"
I am assigned as debugger when DAPServer is not found
"
Class {
	#name : #IPDummyDAPServer,
	#superclass : #Object,
	#category : #'IPharo-Core'
}

{ #category : #testing }
IPDummyDAPServer >> isInitialized [
	^ false
]

{ #category : #accessing }
IPDummyDAPServer >> isRunning [ 
	^ false
]

{ #category : #accessing }
IPDummyDAPServer >> pluggableCompilationBlock: doNothing [
]

{ #category : #accessing }
IPDummyDAPServer >> stop [
]
