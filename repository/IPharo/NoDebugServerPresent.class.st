Class {
	#name : #NoDebugServerPresent,
	#superclass : #Object,
	#category : #'IPharo-Core'
}

{ #category : #testing }
NoDebugServerPresent >> isInitialized [
	^ false
]

{ #category : #accessing }
NoDebugServerPresent >> isRunning [ 
	^ false
]

{ #category : #accessing }
NoDebugServerPresent >> pluggableCompilationBlock: doNothing [
]

{ #category : #accessing }
NoDebugServerPresent >> stop [
]
