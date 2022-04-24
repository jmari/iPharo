"
I am a kernel Proxy, it means I can interface a a client (notebook) with the Kernel. I can configure and start a kernel and keep the connection alive. 

I am the handler for the ioPub messages received by my ioSubscriber processor, I also implement an interface for easing the message sending and receive the reply message from the kernel.
"
Class {
	#name : #IPKernelProxy,
	#superclass : #Object,
	#instVars : [
		'heartbeat',
		'shell',
		'control',
		'stdin',
		'ioPub',
		'connectionConfig',
		'kernelPipe',
		'wireMessage',
		'subscriber',
		'sharedKey',
		'kernelStatus',
		'sessionId'
	],
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPKernelProxy class >> buildKernelProxyFromConfigFile: aFilename [
	| kernelConfig className rs myclass methodTemplate methodSource path kernelName |
	path := aFilename asPath.
	kernelName := (path at: path size - 1) asCamelCase.
	rs :=aFilename asFileReference readStream.
	kernelConfig := SCMaterializer materializeFrom:  rs.
	rs close.
	
	className := 'IP', kernelName, 'KernelProxy'.
	myclass := IPKernelProxy 
		subclass: className asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'IPharo-KernelProxy-Core'.
	
	methodTemplate :='displayName
	^ ''{1}'''.
	methodSource := methodTemplate format:{kernelConfig display_name}.
	myclass compile:methodSource.
	methodTemplate :='executableFileName
	^ ''{1}'''.
	methodSource := methodTemplate format:{kernelConfig argv first}.
	myclass compile:methodSource.
	methodSource :='executableOptions
	^ {',
	('. ' join:((kernelConfig argv allButFirst select:[:o| (o asString includesSubstring:'connection_file') not]) collect:[:o| '''',o asString,'''' ])) ,
	'. self connectionFileName}'.
	myclass compile:methodSource.
	methodTemplate :='metadata
	^ ''{1}'''.
	methodSource := methodTemplate format:{kernelConfig metadata}.
	myclass compile:methodSource.
	methodTemplate :='language
	^ ''{1}'''.
	methodSource := methodTemplate format:{kernelConfig language}.
	myclass compile:methodSource.

]

{ #category : #tests }
IPKernelProxy class >> test1 [
	self buildKernelProxyFromConfigFile: '/Users/Cat/anaconda3/envs/jupyterlab-debugger/share/jupyter/kernels/xpython/kernel.json'
]

{ #category : #tests }
IPKernelProxy class >> test2 [
	self buildKernelProxyFromConfigFile: '/Users/Cat/anaconda3/envs/jupyterlab-debugger/share/jupyter/kernels/python3/kernel.json'
]

{ #category : #tests }
IPKernelProxy class >> test3 [
	self buildKernelProxyFromConfigFile: '/Users/Cat/Library/Jupyter/kernels/javascript/kernel.json'
]

{ #category : #'message-handlers' }
IPKernelProxy >> addHandler: aMessageHandler [
	subscriber addHandlersFromPragmasInClass: aMessageHandler class handlerInstance: aMessageHandler.
	
]

{ #category : #utility }
IPKernelProxy >> buildConnectionConfigFile [
	| ws reference |
	reference := self connectionFileName asFileReference.
	reference ifExists: [ reference delete ].
	reference ensureCreateFile.
	ws := reference writeStream.
	ws << self connectionConfig asJson. 
	ws close
]

{ #category : #utility }
IPKernelProxy >> buildKernelStartCommand [
	| ws |
	ws := WriteStream on: String new.
	ws << self executableFileName.
	self executableOptions do:[ :op |
		ws << ' '.
		ws << op ].
	ws << (' 2> ', self className , '.err').
	^ ws contents	
	
	
]

{ #category : #'public-api' }
IPKernelProxy >> completeRequest: aStringWithCode cursorPos: anInteger [
	| message |
	message := IPCompleteRequestMsg new.
	message code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: message onSocket: shell.
	^ self receiveMessageOnSocket: shell 

	
]

{ #category : #'public-api-async' }
IPKernelProxy >> completeRequest: aStringWithCode cursorPos: anInteger onSucceed: aBlockWithOneArgument [
	| message |
	message := IPCompleteRequestMsg new.
	message code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: message onSocket: shell.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: shell) ] fork

	
]

{ #category : #accessing }
IPKernelProxy >> connectionConfig [
	^ connectionConfig ifNil:[ connectionConfig := IPConnectionConfig new initialize]
]

{ #category : #utility }
IPKernelProxy >> connectionFileName [ 
	^ '/tmp/' , self className 
	
]

{ #category : #utility }
IPKernelProxy >> connectionStringFor:transport ip:anIp port:aPort [
	"build the connection string for a zmq socket"
	^ transport asString , '://' , anIp asString, ':' ,aPort asString
]

{ #category : #'public-api-debug' }
IPKernelProxy >> debugRequest: dapContent [
	| message |
	message := IPDebugRequestMsg new.
	message content: dapContent.
	self sendMessage: message  onSocket: control.
	^ self receiveMessageOnSocket: control
]

{ #category : #'public-api-debug' }
IPKernelProxy >> debugRequest: dapContent onSucceed: aBlockWithOneArgument [
	| message |
	message := IPDebugRequestMsg new.
	message content: dapContent.
	self sendMessage: message  onSocket: control.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: control) ] fork
]

{ #category : #'kernel-management' }
IPKernelProxy >> defaultKernelFileContents [
	
	^ '{
  "argv": [
  "', FileLocator vmBinary fullName,'",
  "--headless", "', FileLocator image fullName, '",
  "ipharo",
  "{connection_file}"
	],
	"display_name": "Pharo Smalltalk",
	"language": "smalltalk",
	"metadata": { "debugger": true }
	}'
]

{ #category : #'kernel-management' }
IPKernelProxy >> displayName [
	"display name can be used by the front to display the kernel name"
	^ self subclassResponsibility 
]

{ #category : #'kernel-management' }
IPKernelProxy >> executableFileName [
	" full path to the executable"
	^ self subclassResponsibility 
]

{ #category : #'kernel-management' }
IPKernelProxy >> executableOptions [
	"executable options, I.E. image path or any stat up option, last option is the kernel name and kernel ports configuration filename"
	^ self subclassResponsibility 
]

{ #category : #'public-api' }
IPKernelProxy >> executeRequest: aStringWithCode [
	| message |
	message := IPExecuteRequestMsg new.
	message code: aStringWithCode.
	self sendMessage: message  onSocket: shell.
	^ self receiveMessageOnSocket: shell
	

	
]

{ #category : #'public-api-async' }
IPKernelProxy >> executeRequest: aStringWithCode onSucceed: aBlockWithOneArgument [
	| message |
	message := IPExecuteRequestMsg new.
	message code: aStringWithCode.
	self sendMessage: message  onSocket: shell.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: shell) ] fork
	

	
]

{ #category : #'public-api' }
IPKernelProxy >> historyLast: anInteger [
	| message |
	message := IPHistoryRequestMsg  new.
	message content hist_access_type: #tail.
	message content n:3.
	self sendMessage: message onSocket: shell.
	^ self receiveMessageOnSocket: shell 

	
]

{ #category : #'public-api-async' }
IPKernelProxy >> historyLast: anInteger onSucceed: aBlockWithOneArgument [
	| message |
	message := IPHistoryRequestMsg  new.
	message content hist_access_type: #tail.
	message content n:3.
	self sendMessage: message onSocket: shell.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: shell) ] fork

	
]

{ #category : #initialization }
IPKernelProxy >> initialize [
	super initialize.
	ZmqContext current.
	self initializeClientPorts. 
	self startHeartbeatThread.
	self startSubscriberProcessor. 
	self startKernel.

	

]

{ #category : #initialization }
IPKernelProxy >> initializeClientPorts [
	| kernelConfig |
	"heartbeat must request the heartbeat to the Kernel
	 Client is a subscribet to ioPub, kernel is the publisher
	shell, control, stdin are Dealers"
	
	heartbeat := ZmqRequestSocket new.
	shell := ZmqDealerSocket new. 
	control := ZmqDealerSocket new. 
	stdin := ZmqDealerSocket new. 
	ioPub := ZmqSubscriberSocket new.
	
	kernelConfig := self connectionConfig.
	sharedKey := (kernelConfig at:#key).
	heartbeat connect: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#hb_port)).
	stdin connect: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#stdin_port)).
	control connect:(self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#control_port)).
	shell connect: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#shell_port)).
	ioPub connect: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#iopub_port)).
	ioPub subscribeAll.
	
]

{ #category : #'public-api' }
IPKernelProxy >> inspectRequest: aStringWithCode cursorPos: anInteger [
	| message |
	message := IPInspectRequestMsg new.
	message code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: message onSocket: shell.
	^ self receiveMessageOnSocket: shell 

	
]

{ #category : #'public-api-async' }
IPKernelProxy >> inspectRequest: aStringWithCode cursorPos: anInteger onSucceed: aBlockWithOneArgument [
	| message |
	message := IPInspectRequestMsg new.
	message code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: message onSocket: shell.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: shell) ] fork

	
]

{ #category : #'public-api' }
IPKernelProxy >> isCompleteRequest: code [
	| message |
	message := IPIsCompleteRequestMsg new.
	message content code: code.
	self sendMessage: message onSocket: shell.
	^ self receiveMessageOnSocket: shell 

	
]

{ #category : #'public-api-async' }
IPKernelProxy >> isCompleteRequest: code onSucceed: aBlockWithOneArgument [
	| message |
	message := IPIsCompleteRequestMsg new.
	message content code: code.
	self sendMessage: message onSocket: shell.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: shell) ] fork

	
]

{ #category : #'public-api' }
IPKernelProxy >> kernelInfoRequest [
	| message |
	message := IPKernelInfoRequestMsg new.
	self sendMessage: message onSocket: shell.
	^ self receiveMessageOnSocket: shell 

	
]

{ #category : #'public-api-async' }
IPKernelProxy >> kernelInfoRequestOnSucceed: aBlockWithOneArgument [
	| message |
	message := IPKernelInfoRequestMsg new.
	self sendMessage: message onSocket: shell.
	[ aBlockWithOneArgument value: (self receiveMessageOnSocket: shell) ] fork

	
]

{ #category : #'public-api' }
IPKernelProxy >> kernelShutdown [
	| message shutdownMsg |
	message := IPKernelShutdownMsg new.
	self sendMessage: message onSocket: control.
	"self receiveWireMessage should be done after idle messag on iopub"
	shutdownMsg :=self receiveMessageOnSocket: control.
	IPSession finalizeSession: shutdownMsg header session .
	^ shutdownMsg
]

{ #category : #'public-api-async' }
IPKernelProxy >> kernelShutdownOnSucceed: aBlockWithOneArgument [
	| message shutdownMsg |
	message := IPKernelShutdownMsg new.
	self sendMessage: message onSocket: control.
	[ 
		shutdownMsg :=self receiveMessageOnSocket: control.
		IPSession finalizeSession: shutdownMsg header session .
		aBlockWithOneArgument value: shutdownMsg ] fork
	
]

{ #category : #'kernel-management' }
IPKernelProxy >> kernelStatus [
	^ kernelStatus
]

{ #category : #accessing }
IPKernelProxy >> language [
	"returns the language"
	^ self subclassResponsibility 
]

{ #category : #accessing }
IPKernelProxy >> messageDelimiter [ 
	^'<IDS|MSG>'
]

{ #category : #accessing }
IPKernelProxy >> metadata [
	"returns an array of metadata"
	^ self subclassResponsibility 
]

{ #category : #'private-messaging' }
IPKernelProxy >> pushMessageFrame:messageData [ 

	(messageData =  (self messageDelimiter asByteArray))
				ifTrue:[ self wireMessage delimiterReceived ]
				ifFalse:[ self wireMessage push:messageData ]

						
	

]

{ #category : #'private-messaging' }
IPKernelProxy >> receiveMessageOnSocket: aZmqSocket [
	|more messageData |
	self wireMessage: IPWireMessage new.
	more := 1.
	
	[more = 1] whileTrue:[
			messageData := aZmqSocket waitTilReceive.  
			more:= aZmqSocket getOption: ZmqApiConstants zmqRcvMore.
			messageData isEmpty 
							ifTrue:[							
									Processor yield.
									(Delay forMilliseconds: 100) wait ]
							ifFalse:[ self pushMessageFrame:messageData ].
							more = 0 ifTrue: [ ^ IPMsg newFromWireMessage: self wireMessage] ] .	
]

{ #category : #'private-messaging' }
IPKernelProxy >> sendMessage: anIPRequest onSocket: aZmqSocket [
	| aRequest |
	"set current session id"
	anIPRequest header session: self sessionId.
	aRequest := IPWireMessage newFromMessage: anIPRequest sharedKey: sharedKey.
	aZmqSocket ifNotNil: [ 
		aZmqSocket  
				send: aRequest uuid flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest hmac flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest header flags:ZmqApiConstants  zmqSendMore;
				send: aRequest parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest metadata flags:ZmqApiConstants  zmqSendMore;
				send: aRequest content ]
]

{ #category : #accessing }
IPKernelProxy >> sessionId [ 

	^ sessionId ifNil:[ sessionId := UUID new hex asString asUppercase ]
]

{ #category : #initialization }
IPKernelProxy >> startHeartbeatThread [
	[	|echoData stop|
		echoData := #[1 2 3]. 
		stop := false.
		[ stop ] whileFalse:[
			heartbeat send: echoData.
			(Delay forMilliseconds: 5000) wait.
			heartbeat receiveIfAvailable: [ :echo|  
				(echoData = echo) ifFalse:[
					stop := true ] ] ].
		IPHeartbeatError signal. 
	] forkNamed:'ipharo-proxy-echo' 
]

{ #category : #'kernel-management' }
IPKernelProxy >> startKernel [
	"starts the Kernel"
	kernelStatus := #starting.
	self buildConnectionConfigFile.
	kernelPipe := LibC pipe: self buildKernelStartCommand mode: 'r'.
]

{ #category : #initialization }
IPKernelProxy >> startSubscriberProcessor [
	subscriber := IPIOSubscriberProcessor new: ioPub sharedKey: sharedKey.
	"I am the responsible for reply message handling in iopub
	and also a subclass can hancle a reply message"
	subscriber addHandlersFromPragmasInClass: self class superclass handlerInstance: self.
	subscriber addHandlersFromPragmasInClass: self class handlerInstance: self  
]

{ #category : #'message-handlers' }
IPKernelProxy >> statusReply: anIPMessage [
	<ipharo: #status>
	
	kernelStatus := anIPMessage content execution_state.

	


]

{ #category : #finalization }
IPKernelProxy >> stop [
	self kernelShutdown.
	LibC pipeClose: kernelPipe.
	"close sockets"
	shell close.
	ioPub close.
	control close.
	stdin close.
	subscriber stop.
	

	

]

{ #category : #'as yet unclassified' }
IPKernelProxy >> timeout [
	^ 10000 "ms"
]

{ #category : #'private-messaging' }
IPKernelProxy >> wireMessage [
	^ wireMessage
]

{ #category : #'private-messaging' }
IPKernelProxy >> wireMessage: aWireMessage [

	wireMessage := aWireMessage.
	wireMessage sharedKey: sharedKey
]
