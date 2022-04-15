"
I want to be the kernel Proxy in the future, please do not use me.
I have to start the IPharo kernel and provide messaging for commands execution.


Public API and Key Messages

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	control:		<Object>
	heartbeat:		<Object>
	ioPub:		<Object>
	shell:		<Object>
	stdin:		<Object>


    Implementation Points
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
		'kernelStatus'
	],
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #utility }
IPKernelProxy >> buildConnectionConfigFile [
	| ws |
	ws := self connectionFileName asFileReference writeStream.
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
	^ ws contents	
	
	
]

{ #category : #'public-messaging' }
IPKernelProxy >> completeRequest: aStringWithCode cursorPos: anInteger [
	| message |
	message := IPCompleteRequestMsg new.
	message code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: message onSocket: shell.

	
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

{ #category : #'message-handlers-shell' }
IPKernelProxy >> executeReply: anIPMessage [
	<ipharo: #execute_result>
	anIPMessage inspect.
	self receiveWireMessage 

]

{ #category : #'public-messaging' }
IPKernelProxy >> executeRequest: aStringWithCode [
	| message |
	message := IPExecuteRequestMsg new.
	message code: aStringWithCode.
	self sendMessage: message  onSocket: shell..
	"self receiveWireMessage should be done after idle message" 

	
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

{ #category : #'message-handlers-control' }
IPKernelProxy >> kernelInfoReply: anIPMessage [
	<ipharo: #kernel_info_reply>
	
	self receiveWireMessage 

]

{ #category : #'public-messaging' }
IPKernelProxy >> kernelInfoRequest [
	| message |
	message := IPKernelInfoRequestMsg new.
	self sendMessage: message onSocket: shell.
	"self receiveWireMessage should be done after idle messag on iopub"

	
]

{ #category : #'public-messaging' }
IPKernelProxy >> kernelShoutdown [
	| message |
	message := IPKernelShutdownMsg new.
	self sendMessage: message onSocket: control.
	"self receiveWireMessage should be done after idle messag on iopub"

	
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
IPKernelProxy >> receiveWireMessage [
	|more|
	self wireMessage: IPWireMessage new.
	more := 1.
	[more = 1] whileTrue:[
		shell receiveIfAvailable: [ :messageData|  
							more:= shell getOption: ZmqApiConstants zmqRcvMore.
							messageData isEmpty 
							ifTrue:[							
									Processor yield.
									(Delay forMilliseconds: 500) wait ]
							ifFalse:[ self pushMessageFrame:messageData ].
							more = 0 ifTrue: [ 
								(IPMsg newFromWireMessage: self wireMessage ) inspect ] ] ].	
]

{ #category : #'private-messaging' }
IPKernelProxy >> sendMessage: anIPRequest onSocket: aZmqSocket [
	| aRequest |
	
	aRequest := IPWireMessage newFromMessage: anIPRequest sharedKey: sharedKey.
	aZmqSocket ifNotNil: [ 
		aZmqSocket  
				send: aRequest uuid flags:ZmqApiConstants  zmqSendMore;
				send: aRequest uuid flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest hmac flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest header flags:ZmqApiConstants  zmqSendMore;
				send: aRequest parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest metadata flags:ZmqApiConstants  zmqSendMore;
				send: aRequest content ]
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

{ #category : #'message-handlers-shell' }
IPKernelProxy >> statusReply: anIPMessage [
	<ipharo: #status>
	
	kernelStatus := anIPMessage content execution_state.

	


]

{ #category : #'kernel-management' }
IPKernelProxy >> stopKernel [
	"should execute stop command"
	
	self kernelShoutdown.

	"close sockets"
	shell close.
	ioPub close.
	control close.
	stdin close.
	subscriber stop.
	LibC pipeClose: kernelPipe.
	

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
