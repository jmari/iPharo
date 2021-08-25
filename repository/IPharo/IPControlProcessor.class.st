Class {
	#name : #IPControlProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'debuggerServer',
		'dapServerPort',
		'clientSocket',
		'controlReplay'
	],
	#classInstVars : [
		'dapServerPort'
	],
	#category : #'IPharo-Core'
}

{ #category : #execution }
IPControlProcessor >> dapClientSocket [

	| serverAddress |
	^ clientSocket 
		ifNil:[
			clientSocket := Socket newTCP.
			serverAddress := NetNameResolver addressForName: '127.0.0.1'.
			clientSocket connectTo: serverAddress port: dapServerPort;waitForConnectionFor: 10. 
			clientSocket ]
		ifNotNil:[
			clientSocket isConnected 
				ifTrue:[ clientSocket ]
				ifFalse:[ 
					clientSocket closeAndDestroy.
					clientSocket := nil.
					self dapClientSocket ] ]
	
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
	
	message := IPMsg newFromWireMessage: aWireMessage.
	session := IPSession getSessionForMessage: message.
	self dapServer.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.

]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| clnSocket response data event dapRequest session dataReceived dTokens |
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.
	clnSocket := self dapClientSocket.
	data:={} asSCJsonObject.
	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, String cr, dapRequest.
	self dapServer compileContext: session myContext.
	clnSocket sendData: dapRequest.
	
	dataReceived := clnSocket receiveData.
	dTokens := dataReceived findTokens: String crlf.
	dTokens := dTokens select:[ :each | each size > 1 ].

	dTokens allButFirst do:[ : aDAPMessage |
		data := SCMaterializer materializeFromString: aDAPMessage.
		data type = #event 
			ifTrue:[ 
				event := session debugEventMsg.
				event content: data.
				self publish: event ]
			ifFalse:[	
				response content: data.
				self sendMessage: response ] ]
	
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
