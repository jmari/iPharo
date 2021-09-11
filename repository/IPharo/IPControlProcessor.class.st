Class {
	#name : #IPControlProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'debuggerServer',
		'dapServerPort',
		'clientSocket',
		'controlReplay',
		'mutex'
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
	session dapServer pluggableCompilationBlock: session pluggableCompilationBlock.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.

]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| clnSocket response data event dapRequest dataReceived session bytesRead dTokens |
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.
	clnSocket := session dapClientSocket.
	data:={} asSCJsonObject.
	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, dapRequest.

	clnSocket sendData: dapRequest.
	dataReceived  := String new: 65536.
	bytesRead := clnSocket receiveDataTimeout:1000 into: dataReceived.
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
					IPharoKernel instance publisher publish: event ]
				ifFalse:[	
					response := session debugReplyMsg.
					response content: data.
					self sendMessage: response ] ] .


	

	 
]

{ #category : #'message-handling' }
IPControlProcessor >> executeShutdown: aMessage [
	<ipharo: #shutdown_request>
	| session |
	session := IPSession getSessionForMessage: aMessage.
	session dapServer stop.
	Smalltalk snapshot: false andQuit: true 
]

{ #category : #initialization }
IPControlProcessor >> initialize [ 
	super initialize.
	mutex := Mutex new
]

{ #category : #accessing }
IPControlProcessor >> threadName [
	^ 'ipharo-control' 
]
