Class {
	#name : #IPControlProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'debuggerServer',
		'dapServerPort'
	],
	#classInstVars : [
		'dapServerPort'
	],
	#category : #'IPharo-Core'
}

{ #category : #execution }
IPControlProcessor >> dapServer [

	^ debuggerServer ifNil:[debuggerServer := DAPServer new ]
]

{ #category : #execution }
IPControlProcessor >> execute: aWireMessage [
	| message |
	dapServerPort := self dapServer start.
	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		

]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| serverAddress clientSocket request response data event dapRequest |
		
	request := IPDebugRequestMsg  newFromWireMessage: aMessage.
	response := IPDebugReplyMsg newReplyingToWireMessage: aMessage.

	serverAddress := NetNameResolver addressForName: '127.0.0.1'.
	clientSocket := Socket newTCP.
	self halt.
	data :={} asSCJsonObject.
	[ clientSocket connectTo: serverAddress port: dapServerPort;
	  waitForConnectionFor: 10. 
	  dapRequest := (SCSerializer serialize: request content).
	  dapRequest := 'Content-Length: ', dapRequest size asString , dapRequest, String cr.
	  clientSocket sendData: dapRequest.
	  data := SCMaterializer materializeFromString: clientSocket receiveData] ensure: [ clientSocket closeAndDestroy ].
	data event ifNotNil:[ 
		event := IPDebugEventMsg newReplyingToWireMessage: aMessage.
		event content: event asSCJsonObject.
		self publish: event ].
	response content: data.
	self sendMessage: response
	
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
