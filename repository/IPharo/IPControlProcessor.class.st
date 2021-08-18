Class {
	#name : #IPControlProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'debuggerServer'
	],
	#category : #'IPharo-Core'
}

{ #category : #execution }
IPControlProcessor >> debuggerServer [
	^ debuggerServer ifNil:[
		debuggerServer := PharoDAP start ]
]

{ #category : #execution }
IPControlProcessor >> execute: aWireMessage [
	| message |
	
	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		
]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	
	
]

{ #category : #'message-handling' }
IPControlProcessor >> executeShutdown: aMessage [
	<ipharo: #shutdown_request>
	
	Smalltalk snapshot: false andQuit: true 
]

{ #category : #accessing }
IPControlProcessor >> threadName [
	^ 'ipharo-control' 
]
