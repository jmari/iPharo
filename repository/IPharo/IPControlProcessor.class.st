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
	| clnSocket response data event dapRequest dataReceived session |
	session := IPSession getSessionForMessage: aMessage.
	response := session debugReplyMsg.
	clnSocket := session dapClientSocket.
	data:={} asSCJsonObject.
	dapRequest := (SCSerializer serialize: aMessage content).
	dapRequest := 'Content-Length: ', dapRequest size asString , String cr, dapRequest.

	clnSocket sendData: dapRequest.
	dataReceived := clnSocket receiveData.
	dataReceived := dataReceived copyFrom: (dataReceived indexOf: Character cr) to: dataReceived size.
	data := SCMaterializer materializeFromString: dataReceived deepCopy.


	data type = #event ifNotNil:[ 
		event := session debugEventMsg.
		event content: event asSCJsonObject.
		self publish: event ].
	response content: data.
	self sendMessage: response.
	

	 
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
