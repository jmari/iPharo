Class {
	#name : #ZmqResource,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'parked',
		'context'
	],
	#category : #'ZeroMQ-Core'
}

{ #category : #'instance creation' }
ZmqResource class >> new [
		self error: 'use #onContext instead of #new'
]

{ #category : #'as yet unclassified' }
ZmqResource class >> onContext: aZmqContext [
	|instance|
	instance := self basicNew.
	instance context: aZmqContext.
	instance initialize.
	
	^ instance
]

{ #category : #accessing }
ZmqResource >> context [
	^ context.
]

{ #category : #accessing }
ZmqResource >> context: aZmqContext [
	context := aZmqContext.
]

{ #category : #synchronization }
ZmqResource >> critical: aBlock [
	^ monitor
		critical: [ 
			parked
				ifTrue: [ monitor wait ].
			aBlock value ]
]

{ #category : #'as yet unclassified' }
ZmqResource >> initialize [
	super initialize.
	monitor := Monitor new.
	parked := false.
]

{ #category : #'as yet unclassified' }
ZmqResource >> logDebug: aString [
	ZmqLog logDebug: self asString,': ', aString.
]

{ #category : #'as yet unclassified' }
ZmqResource >> logError: aString [ 
	ZmqLog logError: aString.
]

{ #category : #'as yet unclassified' }
ZmqResource >> parkForSnapshot [
	self parkResource.
]

{ #category : #synchronization }
ZmqResource >> parkResource [
	monitor critical: [ parked := true ]
]

{ #category : #'as yet unclassified' }
ZmqResource >> privateClose [
	
]

{ #category : #'as yet unclassified' }
ZmqResource >> reinitialize [
	self unparkResource.
]

{ #category : #synchronization }
ZmqResource >> unparkResource [
	monitor
		critical: [ 
			parked := false.
			monitor signalAll ]
]
