"
I'm a message processor for the Control channel, I process messages comming from the control socket, I have a thread who reads the socket stream and composes a wire message, once I have a full message receive search for a handler to execute the message.
I am responsible for debugger and shutdown messages. 
 
"
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
	session := message session.
	session dapServer pluggableCompilationBlock: session pluggableCompilationBlock.
	self publish: session kernelStatusBusyMessage.
	self handleRequest: message.	
	self publish:  session kernelStatusIdleMessage.

]

{ #category : #'message-handling' }
IPControlProcessor >> executeDebugRequest: aMessage [
	<ipharo: #debug_request>
	| clnSocket response data dapRequest session |

	((aMessage content command = #source) 
		and:[prevMessage  isNil
		and:[aMessage content arguments source path isNil ] ]) ifTrue:[ 
		"this source command is sended before setting the scope, so we need to keep it,
		 and execute it later because source is not specified"
		prevMessage:= aMessage.
		^ self].
	((aMessage content command = #scopes) and:[prevMessage  notNil]) ifTrue:[ 
		"now we now whap scope we have to return its time to set the correct source...
		it is a hack because jupyterlab always ask for sourceRef = 0"
		session :=  prevMessage session.
		session dapServer setCodeForFrameId: aMessage content arguments frameId.
		self executeDebugRequest: prevMessage.
		prevMessage := nil.
		"this delay is super important...dont ask me why"
		Processor yield.
		(Delay forDuration: 100 milliSecond ) wait.
		].



	session := aMessage session.
	response := session debugReplyMsg.
	clnSocket := session dapClientSocket.
	data:={} asSCJsonObject.

	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, dapRequest.
	clnSocket sendData: dapRequest.
	" RESPONSE LOOP IS DONE BY A THREAD STARTED BY SESSION"
	Processor yield.
	(Delay forDuration: 100 milliSecond ) wait.

]

{ #category : #'message-handling' }
IPControlProcessor >> executeShutdown: aMessage [
	<ipharo: #shutdown_request>
	| session response |
	session := aMessage session.
	response := session kernelShutdownReplyMsg.
	self sendMessage: response. 
	session dapServer stop.
	Smalltalk snapshot: false andQuit: true 
]

{ #category : #accessing }
IPControlProcessor >> threadName [
	^ 'ipharo-control' 
]
