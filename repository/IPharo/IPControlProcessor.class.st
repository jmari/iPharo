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

	^ debuggerServer ifNil:[
		debuggerServer := DAPServer new.
		dapServerPort := debuggerServer start.
		debuggerServer ]
]

{ #category : #execution }
IPControlProcessor >> execute: aWireMessage [
	| message |
	self dapServer.
	message := IPMsg newFromWireMessage: aWireMessage.
	self handleRequest: message.		

]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| serverAddress clientSocket response data event dapRequest dataReceived session |
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.
	serverAddress := NetNameResolver addressForName: '127.0.0.1'.
	clientSocket := Socket newTCP.
	data:={} asSCJsonObject.
	clientSocket connectTo: serverAddress port: dapServerPort;
	waitForConnectionFor: 10. 
	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, dapRequest.
	clientSocket sendData: dapRequest.
	dataReceived := clientSocket receiveData.
	dataReceived := dataReceived copyFrom: (dataReceived indexOf: Character cr) to: dataReceived size.
	data := SCMaterializer materializeFromString: dataReceived .

	data event ifNotNil:[ 
		event := session debugEventMsg.
		event content: event asSCJsonObject.
		self publish: event ].
	response content: data.
	self sendMessage: response.

	 
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
