Class {
	#name : #IPControlProcessor,
	#superclass : #IPMessageProcessor,
	#instVars : [
		'debuggerServer',
		'dapServerPort',
		'clientSocket',
		'controlReplay',
		'prevMessage'
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
	| clnSocket response data dapRequest session |

	((aMessage content command = #source) and:[prevMessage  isNil]) ifTrue:[ 
		prevMessage:= aMessage.
		^ self].
	((aMessage content command = #scopes) and:[prevMessage  notNil]) ifTrue:[ 
		"now we now whap scope we have to return its time to set the correct source...
		it is a hack because jupyterlab always ask for sourceRef = 0"
		session := IPSession getSessionForMessage: prevMessage.
		session dapServer setCodeForFrameId: aMessage content arguments frameId.
		self executeDebugRequest: prevMessage.
		prevMessage := nil.
		"this delay is super important...dont ask me why"
		Processor yield.
		(Delay forDuration: 10 milliSecond ) wait.
		].
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.
	clnSocket := session dapClientSocket.
	data:={} asSCJsonObject.

	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, dapRequest.
	clnSocket sendData: dapRequest.
	" RESPONSE LOOP IS DONE BY A THREAD STARTED BU SESSION"
	Processor yield.
	(Delay forDuration: 10 milliSecond ) wait.



	

	 
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
	

]

{ #category : #accessing }
IPControlProcessor >> threadName [
	^ 'ipharo-control' 
]
