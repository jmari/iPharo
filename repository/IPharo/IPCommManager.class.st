"
I'm part of the kernel, it uses me. There must be just one instance of me and published by the Kernel on #commManager accessor.

I manage the comm channels, register/unregister a comm channel. Every instance of a IPComm is auto-registered at creation time. Widgets use the comm channel, everyone of them is listening for its channel.

I also keep the default commManager in a class variable. Default comm manager is used by Comms for""autoregistration"" when the instance is created by new. KernelProxy has also a commManager to keep the client side comms so default comm manager will KernelProxy commManager or IPharoKernel commManager.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commChanels:		<Object>
	commMsgHandlers:		<Object>
	targetClasses:		<Object>


    Implementation Points
"
Class {
	#name : #IPCommManager,
	#superclass : #Object,
	#instVars : [
		'commChanels',
		'commMsgHandlers',
		'targetClasses',
		'publisher'
	],
	#classInstVars : [
		'defaultCommManager'
	],
	#category : #'IPharo-Comm'
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

{ #category : #accessing }
IPCommManager >> publisher [

	^ publisher
]

{ #category : #accessing }
IPCommManager >> publisher: anObject [

	publisher := anObject
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
