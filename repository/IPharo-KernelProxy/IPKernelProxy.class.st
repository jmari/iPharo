"
I am a kernel Proxy, it means I can interface a a client (notebook) with the Kernel. I can configure and start a kernel and keep the connection alive. 

I am the handler for the ioPub messages received by my ioSubscriber processor, I also implement an interface for easing the message sending and receive the reply message from the kernel.
"
Class {
	#name : #IPKernelProxy,
	#superclass : #Object,
	#instVars : [
		'heartbeat',
		'timeout',
		'shell',
		'control',
		'stdin',
		'ioSub',
		'connectionConfig',
		'kernelPipe',
		'wireMessage',
		'ioSubProcessor',
		'sharedKey',
		'kernelStatus',
		'session',
		'username',
		'shellProcessor',
		'controlProcessor',
		'stdinProcessor',
		'mutex',
		'stop',
		'echoProcess'
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

{ #category : #'as yet unclassified' }
IPKernelProxy class >> generateAvailableKernelProxyClasses [
	| listOfKernels first kernelPath outString |
	
	outString := LibC resultOfCommand: 'jupyter kernelspec list'.
	listOfKernels := outString findTokens: Character lf.
	listOfKernels allButFirst do:[ :line |
		first := line findString: ' ' startingAt: 12.
		kernelPath := (line copyFrom:first to: line size) trimBoth.
		self buildKernelProxyFromConfigFile: kernelPath , '/kernel.json' ]


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
IPKernelProxy >> addHandlerToControlDealer: aMessageHandler [

	controlProcessor addHandlersFromPragmasInClass: aMessageHandler class handlerInstance: aMessageHandler.
	
]

{ #category : #'message-handlers' }
IPKernelProxy >> addHandlerToIOSubscriber: aMessageHandler [

	ioSubProcessor addHandlersFromPragmasInClass: aMessageHandler class handlerInstance: aMessageHandler.
	
]

{ #category : #'message-handlers' }
IPKernelProxy >> addHandlerToShellDealer: aMessageHandler [

	shellProcessor addHandlersFromPragmasInClass: aMessageHandler class handlerInstance: aMessageHandler.
	
]

{ #category : #'message-handlers' }
IPKernelProxy >> addHandlerToStdInDealer: aMessageHandler [

	stdinProcessor addHandlersFromPragmasInClass: aMessageHandler class handlerInstance: aMessageHandler.
	
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

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commCloseRequest: uuid [
	self commCloseRequest: uuid data: SCJsonObject new. 
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commCloseRequest: uuid data: aJsonDict [
	| message |
	message := IPCommCloseMsg new.
	message content at:#comm_id put: uuid.
	message content at:#data put: aJsonDict.
	self sendMessage: message  onSocket: shell.
	
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commInfoRequest [
	^ self commInfoRequest: nil
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commInfoRequest: targetName [
	| queryMessage |
	queryMessage := IPCommInfoRequestMsg new.
	targetName ifNotNil:[ queryMessage content at:#target_name put: targetName].
	self sendMessage: queryMessage onSocket: shell.
	^ self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #comm_info_reply 
	
	

]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commMessageRequest: uuid [
	self commMessageRequest: uuid data: SCJsonObject new 
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commMessageRequest: uuid data: aJsonDict [
	| message |
	message := IPCommMsg new.
	message content at:#comm_id put: uuid.
	message content at:#data put: aJsonDict.
	self sendMessage: message  onSocket: shell.

]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commOpenRequest: uuid [
	self commOpenRequest: uuid targetName: nil 
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> commOpenRequest: uuid targetName: targetName [
	| message |
	message := IPCommOpenMsg new.
	message content at:#comm_id put: uuid.
	targetName ifNotNil:[ message content at:#target_name put: targetName].
	self sendMessage: message  onSocket: shell.

]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> completeRequest: aStringWithCode cursorPos: anInteger [
	| queryMessage |
	queryMessage := IPCompleteRequestMsg new.
	queryMessage code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: queryMessage onSocket: shell.
	^ self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #complete_reply

	
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

{ #category : #'public-api-control-dealer' }
IPKernelProxy >> debugRequest: dapContent [
	| queryMessage |
	queryMessage := IPDebugRequestMsg new.
	queryMessage content: dapContent.
	self sendMessage: queryMessage onSocket: control.
	^ self receiveMessageOnProcessor: controlProcessor  replyingTo: queryMessage ofType: #debug_reply 
	
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

{ #category : #'private-messaging' }
IPKernelProxy >> defaultTimeOut [ 
	"in ms"
	^ 2000
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

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> executeDebugRequest: aStringWithCode [
	| queryMessage ioSubResponse  |
	queryMessage := IPExecuteRequestMsg new.
	queryMessage code: aStringWithCode.
	queryMessage := ioSubResponse := nil. 
	^  self sendMessage: queryMessage  onSocket: shell.
	
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> executeRequest: aStringWithCode [
	| queryMessage shellResponse controlResponse p1 p2  |
	"response could come from control if we are debugging, "
	queryMessage := IPExecuteRequestMsg new.
	queryMessage code: aStringWithCode.
	controlResponse := shellResponse := nil. 
	self sendMessage: queryMessage  onSocket: shell.
	p1:=[ shellResponse := self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #execute_reply ] fork.
	p2:=[ controlResponse := self receiveMessageOnProcessor: ioSubProcessor  replyingTo: queryMessage ofType: #debug_event] fork.  
	[ shellResponse isNil & controlResponse isNil ] whileTrue:[
								( Delay forMilliseconds: 10 ) wait].
	p1 terminate.
	p2 terminate.

	^ shellResponse notNil 
		ifTrue:[ shellResponse ] 
		ifFalse:[ controlResponse ]
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> historyLast: anInteger [
	| queryMessage |
	queryMessage := IPHistoryRequestMsg  new.
	queryMessage content at:#hist_access_type put:#tail.
	queryMessage content at:#n put: anInteger.
	self sendMessage: queryMessage onSocket: shell.
	^ self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #history_reply 
]

{ #category : #initialization }
IPKernelProxy >> initialize [
	super initialize.
	mutex := Mutex new.
	ZmqContext current.
	self initializeClientPorts. 
	self startHeartbeatThread.
	self startSubscriberProcessor. 
	self startShellProcessor.
	self startStdInProcessor.
	self startControlProcessor.
	self startKernel.
	self session

	

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
	ioSub := ZmqSubscriberSocket new.
	
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
	ioSub connect: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#iopub_port)).
	ioSub subscribeAll.
	
]

{ #category : #'public-api-stdin' }
IPKernelProxy >> inputRequestHandler: anIPMessage [
	<ipharo: #input_request>
	| userResponse msgReply |
	userResponse :=anIPMessage content password 
		ifTrue:[ UIManager default requestPassword: anIPMessage content prompt ]
		ifFalse:[ UIManager default request: anIPMessage content prompt ].
	msgReply := self session inputReplayMessage.
	msgReply content at:#value put:userResponse.
	self sendMessage:  msgReply onSocket: stdin 
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> inspectRequest: aStringWithCode cursorPos: anInteger [
	| queryMessage |
	queryMessage := IPInspectRequestMsg new.
	queryMessage code: aStringWithCode cursorPos: anInteger. 
	self sendMessage: queryMessage onSocket: shell.
	^ self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #inspect_reply 


	
]

{ #category : #'public-api-control-dealer' }
IPKernelProxy >> interruptRequest [
	| queryMessage |
	queryMessage := IPInterruptRequestMsg new.
	self sendMessage: queryMessage onSocket: control.
	^ self receiveMessageOnProcessor: controlProcessor  replyingTo: queryMessage ofType: #interrupt_reply
	
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> isCompleteRequest: code [
	| queryMessage |
	queryMessage := IPIsCompleteRequestMsg new.
	queryMessage content code: code.
	self sendMessage: queryMessage onSocket: shell.
	^ self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #is_complete_reply 
	

	
]

{ #category : #'public-api-shell-dealer' }
IPKernelProxy >> kernelInfoRequest [
	| queryMessage |
	queryMessage := IPKernelInfoRequestMsg new.
	self sendMessage: queryMessage onSocket: shell.
	^ self receiveMessageOnProcessor: shellProcessor  replyingTo: queryMessage ofType: #kernel_info_reply
	
	

	
]

{ #category : #'public-api-control-dealer' }
IPKernelProxy >> kernelShutdown [
	| message shutdownMsg |
	message := IPKernelShutdownMsg new.
	self sendMessage: message onSocket: control.
	shutdownMsg :=self receiveMessageOnSocket: control.
	
	IPSession finalizeSession: shutdownMsg header session.
	^ shutdownMsg
]

{ #category : #accessing }
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

{ #category : #'public-api-iosub-display' }
IPKernelProxy >> onDebugEventPublishedDo: oneParameterBlock [

	ioSubProcessor handlers first receiver onMessage: #debug_event do: oneParameterBlock
]

{ #category : #'public-api-iosub-display' }
IPKernelProxy >> onDisplayDataPublishedDo: oneParameterBlock [

	ioSubProcessor handlers first receiver onMessage: #display_data do: oneParameterBlock
]

{ #category : #'public-api-iosub-display' }
IPKernelProxy >> onErrorPublishedDo: oneParameterBlock [

	ioSubProcessor handlers first receiver onMessage: #error do: oneParameterBlock
]

{ #category : #'public-api-iosub-display' }
IPKernelProxy >> onExecuteResultPublishedDo: oneParameterBlock [

	ioSubProcessor handlers first receiver onMessage: #execute_result do: oneParameterBlock
]

{ #category : #'public-api-iosub-display' }
IPKernelProxy >> onStreamPublishedDo: oneParameterBlock [

	ioSubProcessor handlers first receiver onMessage: #stream do: oneParameterBlock
]

{ #category : #'public-api-iosub-display' }
IPKernelProxy >> onUpdateDisplayDataPublishedDo: oneParameterBlock [

	ioSubProcessor handlers first receiver onMessage: #update_display_data do: oneParameterBlock
]

{ #category : #finalization }
IPKernelProxy >> publish: anIPMessage [
	"kernel proxy send the message trough the shell socket, kernel reply on iopub"
	self sendMessage: anIPMessage onSocket: shell 
	

	

]

{ #category : #'private-messaging' }
IPKernelProxy >> pushMessageFrame:messageData [ 

	(messageData =  (self messageDelimiter asByteArray))
				ifTrue:[ self wireMessage delimiterReceived ]
				ifFalse:[ self wireMessage push:messageData ]

						
	

]

{ #category : #'private-messaging' }
IPKernelProxy >> receiveMessageOnProcessor: aMessageProcessor replyingTo: aRequestMessage ofType: aMsgTypeCollection [
	| myReply receiver timeOut msgTypeCollection |
	"This is so complex but you send a msg trough a socket and you receive asynchronously by other
	so the solution is to evaluate each message and check if it is the reply for our message.
	#handleFor returns a collection of (method) handlers, first handler receiver should be the 
	assigned IPMsgHandler in the #initialize of the processor, so the first handler added to the 
	processor is what we are looking for"
	msgTypeCollection := aMsgTypeCollection isString 
															ifTrue:[ {aMsgTypeCollection} ] 
															ifFalse:[ aMsgTypeCollection ].
	myReply := nil.
	timeOut:= 0.
	receiver := aMessageProcessor handlers first receiver.
	[
	msgTypeCollection do:[ :msgType |	
			receiver onMessage:msgType do:[ :replyMsg |
	 			(((replyMsg parentHeader at:#msg_id) = aRequestMessage uuid) and:[
				(replyMsg header at:#msg_type) = msgType ]) ifTrue:[ myReply := replyMsg] ] ].
	[ myReply isNil and:[timeOut < self defaultTimeOut ] ]  whileTrue:[ 
		(Delay forMilliseconds: 10) wait. 
		timeOut := timeOut + 10  ]
	] ensure:[ msgTypeCollection do:[ :msgType |receiver removeListenerFor: msgType ] ].
	^ myReply 
]

{ #category : #'private-messaging' }
IPKernelProxy >> receiveMessageOnSocket: aZmqSocket [
	|more messageData |
	mutex critical:[
	self wireMessage: IPWireMessage new.
	more := 1.
	[more = 1] whileTrue:[
			messageData := aZmqSocket waitTilReceive.  
			more:= aZmqSocket getOption: ZmqApiConstants zmqRcvMore.
			messageData isEmpty 
							ifTrue:[							
									Processor yield.
									(Delay forMilliseconds: 50) wait ]
							ifFalse:[ self pushMessageFrame:messageData ].
							more = 0 ifTrue: [ ^ IPMsg newFromWireMessage: self wireMessage] ] ].	
]

{ #category : #'private-messaging' }
IPKernelProxy >> sendMessage: anIPRequest onSocket: aZmqSocket [
	| aRequest |
	"set current session id"
	anIPRequest header session: self session id.
	anIPRequest header username: self session username.
	anIPRequest header timestamp: self session startTime. 
	aRequest := IPWireMessage newFromMessage: anIPRequest sharedKey: sharedKey.
	anIPRequest wireMessage: aRequest.
	self session currentMessage: anIPRequest.
	aZmqSocket ifNotNil: [ 
		mutex critical:[
			aZmqSocket  
				send: aRequest uuid flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest hmac flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest header flags:ZmqApiConstants  zmqSendMore;
				send: aRequest parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: aRequest metadata flags:ZmqApiConstants  zmqSendMore;
				send: aRequest content ] ].

]

{ #category : #accessing }
IPKernelProxy >> session [
	| aMsg |
	^ session ifNil:[
		"need to get the id session from the kernel"
		session := IPSession new 
							username: self username;
							id: UUID new hex asString asUppercase;
							startTime: DateAndTime now.
		
		aMsg := self kernelInfoRequest.
		aMsg ifNotNil:[ session := aMsg session ].
		session publisher: self. 
		session  ]
]

{ #category : #initialization }
IPKernelProxy >> startControlProcessor [
	controlProcessor := IPControlDealerProcessor new: control sharedKey: sharedKey.
	self addHandlerToControlDealer:  IPControlMsgHandler new.
	
	"I am the responsible for reply message handling in control socket
	and also a subclass can handle a reply message"
	

]

{ #category : #initialization }
IPKernelProxy >> startHeartbeatThread [

	echoProcess := [	|echoData  error|
		echoData := #[1 2 3]. 
		stop := false.
		error:=false.
		[ stop | error] whileFalse:[
			heartbeat send: echoData.
			(Delay forMilliseconds: 5000) wait.
			heartbeat receiveIfAvailable: [ :echo|  
				(echoData = echo) ifFalse:[
					stop ifFalse:[error := true ] ] ] ].
		error ifTrue:[ IPHeartbeatError signal]. 
	] forkNamed:'ipharo-proxy-echo' 
]

{ #category : #'kernel-management' }
IPKernelProxy >> startKernel [
	"starts the Kernel"
	kernelStatus := #starting.
	self buildConnectionConfigFile.
	"how to set the correct path to find widgets lib in Xpython kernel"
	"OSEnvironment current setEnv: 'PYTHONPATH' value:'/Users/Cat/anaconda3/lib/python3.6/'."
	kernelPipe := LibC pipe: self buildKernelStartCommand mode: 'r'.
]

{ #category : #initialization }
IPKernelProxy >> startShellProcessor [
	shellProcessor := IPShellDealerProcessor new: shell sharedKey: sharedKey.
	"I am the responsible for reply message handling in shell socket
	and also a subclass can handle a reply message"
	

]

{ #category : #initialization }
IPKernelProxy >> startStdInProcessor [
	stdinProcessor := IPStdInDealerProcessor new: stdin sharedKey: sharedKey.
	"I am the responsible for reply message handling in shell socket
	and also a subclass can handle a reply message"
	

]

{ #category : #initialization }
IPKernelProxy >> startSubscriberProcessor [
	ioSubProcessor := IPIOSubscriberProcessor new: ioSub sharedKey: sharedKey.
	"I am the responsible for reply message handling in iopub
	and also a subclass can handle a reply message
	You should add your habler class, I only respond to status msg"
	ioSubProcessor addHandlersFromPragmasInClass: self class superclass handlerInstance: self.
	ioSubProcessor addHandlersFromPragmasInClass: self class handlerInstance: self  
]

{ #category : #'public-api-iosub' }
IPKernelProxy >> statusReply: anIPMessage [
	<ipharo: #status>
	
	kernelStatus := anIPMessage content execution_state.

	


]

{ #category : #finalization }
IPKernelProxy >> stop [
	self kernelShutdown.
	LibC pipeClose: kernelPipe.
	stop := true.
	ioSubProcessor stop.
	shellProcessor stop.
	stdinProcessor stop.
	controlProcessor stop.
	"close sockets"
	ioSub close.
	shell close.
	stdin close.
	control close.
	heartbeat close.
]

{ #category : #accessing }
IPKernelProxy >> timeout [
	^ timeout ifNil:[ timeout :=10000 "ms"]
]

{ #category : #accessing }
IPKernelProxy >> timeout: timeInMilliseconds [
	timeout :=timeInMilliseconds "ms"
]

{ #category : #accessing }
IPKernelProxy >> username [

	^ username ifNil:[ username := self className , self class allInstances size asString ]
]

{ #category : #accessing }
IPKernelProxy >> username: anObject [

	username := anObject
]

{ #category : #accessing }
IPKernelProxy >> widgetFactory [ 
	^ self session widgetFactory
]

{ #category : #'private-messaging' }
IPKernelProxy >> wireMessage [
	"received message"
	^ wireMessage
]

{ #category : #'private-messaging' }
IPKernelProxy >> wireMessage: aWireMessage [
	"used by receiveMessageOnSocket: "
	wireMessage := aWireMessage.
	wireMessage sharedKey: sharedKey
]
