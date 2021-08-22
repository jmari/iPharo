Class {
	#name : #IPControlProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'debuggerServer',
		'dapServerPort',
		'clientSocket'
	],
	#classInstVars : [
		'dapServerPort'
	],
	#category : #'IPharo-Core'
}

{ #category : #execution }
IPControlProcessor >> dapClientSocket [

	| serverAddress |
	^ clientSocket ifNil:[
		clientSocket := Socket newTCP.
		serverAddress := NetNameResolver addressForName: '127.0.0.1'.
		clientSocket connectTo: serverAddress port: dapServerPort;
	waitForConnectionFor: 10. 
		clientSocket ]
]

{ #category : #execution }
IPControlProcessor >> dapServer [

	^ debuggerServer ifNil:[
		debuggerServer := DAPServer new.
		dapServerPort := debuggerServer start.
		debuggerServer ]
]

{ #category : #execution }
IPControlProcessor >> execute: aWireMessage [
	| message session|
	self dapServer.		
	message := IPMsg newFromWireMessage: aWireMessage.
	session := IPSession getSessionForMessage: message.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.
]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| clnSocket response data event dapRequest dataReceived session |
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.
	clnSocket := self dapClientSocket.
	data:={} asSCJsonObject.
	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, dapRequest.

	clnSocket sendData: dapRequest.
	dataReceived := clnSocket receiveData.
	dataReceived := dataReceived copyFrom: (dataReceived indexOf: Character cr) to: dataReceived size.
	data := SCMaterializer materializeFromString: dataReceived deepCopy.


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
