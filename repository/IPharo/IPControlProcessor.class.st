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
IPControlProcessor >> execute: aWireMessage [
	| message session|
	
	message := IPMsg newFromWireMessage: aWireMessage.
	session := IPSession getSessionForMessage: message.
	session dapServer pluggableEvaluationBlock: session pluggableEvaluationBlock.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.

]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| clnSocket response data event dapRequest session dataReceived dTokens bytesRead |
	session := IPSession getSessionForMessage: aMessage.
	Transcript crShow:  aMessage content asString.
	response := session debugReplyMsg.
	clnSocket := session dapClientSocket.		
	data:={} asSCJsonObject.
	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, String cr, dapRequest.
	clnSocket sendData: dapRequest.
	dataReceived  := String new: 65536.
	bytesRead := clnSocket  receiveDataTimeout:1000 into: dataReceived.
	dataReceived := dataReceived copyFrom: 1 to: bytesRead.
	dTokens := dataReceived findTokens: String crlf.
	dTokens := dTokens select:[ :each | each size > 1 ].
	dTokens allButFirst do:[ : aDAPMessage |
		data := SCMaterializer materializeFromString: aDAPMessage.
		Transcript crShow: data asString.
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
	| session |
	session := IPSession getSessionForMessage: aMessage.
	session dapServer stop.
	Smalltalk snapshot: false andQuit: true 
]

{ #category : #accessing }
IPControlProcessor >> threadName [
	^ 'ipharo-control' 
]
