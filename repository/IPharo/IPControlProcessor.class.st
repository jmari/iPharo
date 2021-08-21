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
	| serverAddress clientSocket request response data event dapRequest dataReceived session |
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.

	serverAddress := NetNameResolver addressForName: '127.0.0.1'.
	clientSocket := Socket newTCP.

	data :={} asSCJsonObject.
	[ clientSocket connectTo: serverAddress port: dapServerPort;
	  waitForConnectionFor: 10. 
	  dapRequest := (SCSerializer serialize: aMessage content).
	  dapRequest := 'Content-Length: ', dapRequest size asString , dapRequest, String cr.
	self halt.
	  clientSocket sendData: dapRequest.
	  dataReceived := clientSocket receiveAvailableData.
	  dataReceived := dataReceived copyFrom: (dataReceived indexOf: Character cr) to: dataReceived size.
	  data := SCMaterializer materializeFromString: dataReceived ] ensure: [ clientSocket closeAndDestroy ].

	data event ifNotNil:[ 
		event := session debugEventMsg.
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
