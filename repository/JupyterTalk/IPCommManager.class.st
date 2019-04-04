Class {
	#name : #IPCommManager,
	#superclass : #Object,
	#instVars : [
		'commChanels',
		'commMsgHandlers',
		'targetClasses'
	],
	#category : 'JupyterTalk-Comm'
}

{ #category : #Accessing }
IPCommManager >> commChannelAt: uuid [

	^ self commChannels at:uuid
	
]

{ #category : #Accessing }
IPCommManager >> commChannels [

	^ commChanels ifNil:[commChanels := Dictionary new]
	
]

{ #category : #initialization }
IPCommManager >> initialize [
	super initialize.
	self targetInstances at: 'jupyter.widget' put: IPWidget
]

{ #category : #'comm handlers' }
IPCommManager >> registerComm: aComm [
	self commChannels at:aComm uuid put: aComm

]

{ #category : #Accessing }
IPCommManager >> targetInstances [

	^ targetClasses ifNil:[targetClasses := Dictionary new]
	
]

{ #category : #'comm handlers' }
IPCommManager >> unregisterComm: aCommId [
	self commChannels removeKey: aCommId

]
