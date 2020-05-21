Class {
	#name : #ZmqTerminatedContext,
	#superclass : #Object,
	#category : #'ZeroMQ-Core'
}

{ #category : #'error handling' }
ZmqTerminatedContext >> doesNotUnderstand:  aMessage [
	self error:'Context is terminated' 
]

{ #category : #testing }
ZmqTerminatedContext >> isTerminated [ 
	^true
]

{ #category : #'system startup' }
ZmqTerminatedContext >> parkForSnapshot [
	^ self
]

{ #category : #private }
ZmqTerminatedContext >> privateTerminate [
]

{ #category : #'system startup' }
ZmqTerminatedContext >> reinitialize [
	^ self
]
