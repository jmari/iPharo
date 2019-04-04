"
ZmqVersion represents major-minor-patch type of versioning.

Instance Variables:
	major	<SmallInteger>
	minor	<SmallInteger>
	patch	<SmallInteger>
"
Class {
	#name : #ZmqVersion,
	#superclass : #Magnitude,
	#instVars : [
		'major',
		'minor',
		'patch'
	],
	#category : 'ZeroMQ'
}

{ #category : #'as yet unclassified' }
ZmqVersion class >> fromArray: anThreeElementArrayOfIntegers [
	^self perform: #major:minor:patch: withArguments: anThreeElementArrayOfIntegers.
]

{ #category : #'as yet unclassified' }
ZmqVersion class >> fromString: aString [
	"Conerts minor.major.patch version string e.g. 1.34.12 to ZmqVersion object"

	^self fromArray: ((aString splitOn: $.) collect: [ :part | part asInteger ]) asArray
]

{ #category : #'as yet unclassified' }
ZmqVersion class >> major: major minor: minor patch: patch [
	^ (self new)
		major: major;
		minor: minor;
		patch: patch;
		yourself
]

{ #category : #'as yet unclassified' }
ZmqVersion class >> toVersion: aZmqVersionOrString [
	^ aZmqVersionOrString isString
		ifTrue: [ self fromString: aZmqVersionOrString ]
		ifFalse: [ aZmqVersionOrString ]
]

{ #category : #testing }
ZmqVersion >> < aZMQVersion [
	self major < aZMQVersion major ifTrue:[^true].
	self major > aZMQVersion major ifTrue:[^false].
	self minor < aZMQVersion minor ifTrue:[^true].
	self minor > aZMQVersion minor ifTrue:[^false].
	self patch < aZMQVersion patch ifTrue:[^true].
	self patch > aZMQVersion patch ifTrue:[^false].		
	^false.
]

{ #category : #testing }
ZmqVersion >> = aZMQVersion [
	^ aZMQVersion major = self major and: [ aZMQVersion minor = self minor and: [ aZMQVersion patch = self patch ] ]
]

{ #category : #testing }
ZmqVersion >> between: min and: max [
	^ self >= (self toVersion: min) and: [ self <= (self toVersion: max) ]
]

{ #category : #accessing }
ZmqVersion >> major [
	^ major
]

{ #category : #accessing }
ZmqVersion >> major: anObject [
	major := anObject
]

{ #category : #accessing }
ZmqVersion >> minor [
	^ minor
]

{ #category : #accessing }
ZmqVersion >> minor: anObject [
	minor := anObject
]

{ #category : #accessing }
ZmqVersion >> patch [
	^ patch
]

{ #category : #accessing }
ZmqVersion >> patch: anObject [
	patch := anObject
]

{ #category : #printing }
ZmqVersion >> printOn: aStream [
	aStream nextPutAll: self major asString.
	aStream nextPut: $..
	aStream nextPutAll: self minor asString.	
	aStream nextPut: $..
	aStream nextPutAll: self patch asString.	

	
]

{ #category : #testing }
ZmqVersion >> toVersion: aZmqVersionOrString [
	^ self class toVersion: aZmqVersionOrString.
]
