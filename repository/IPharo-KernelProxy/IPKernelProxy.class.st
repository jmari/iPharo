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
		'subscriber'
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
IPKernelProxy >> displayName [
	"display name can be used by the front to display the kernel name"
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPKernelProxy >> executableFileName [
	" full path to the executable"
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPKernelProxy >> executableOptions [
	"executable options, I.E. image path or any stat up option, last option is the kernel name and kernel ports configuration filename"
	^ self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
IPKernelProxy >> executeReplay: aIPMsg [
	aIPMsg printDirectlyToDisplay 
]

{ #category : #'message sends' }
IPKernelProxy >> executeRequest: aStringWithCode [
	| message |
	message := IPExecuteRequestMsg new.
	message code: aStringWithCode.
	self sendMessage: message.

	
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
	| kernelConfig sharedKey |
	"heartbeat must respond to the Kernel Heartbeat
	 Client is a subscribet to ioPub, kernel is the publisher
	shell, control, stdin are Requesters"
	
	heartbeat := ZmqRequestSocket new.
	shell := ZmqRequestSocket new. 
	control := ZmqRequestSocket new. 
	stdin := ZmqRequestSocket new. 
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

{ #category : #'message sends' }
IPKernelProxy >> pushMessageFrame:messageData [ 

	(messageData =  (self messageDelimiter asByteArray))
				ifFalse:[ self wireMessage push:messageData ]
]

{ #category : #'message sends' }
IPKernelProxy >> sendMessage: anIPRequest [
	| aRequest |
	
	aRequest := IPWireMessage newFromMessage: anIPRequest.
	shell ifNotNil: [ 
		shell  
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

{ #category : #utility }
IPKernelProxy >> startKernel [
	"starts the Kernel"

	self buildConnectionConfigFile.
	kernelPipe := LibC pipe: self buildKernelStartCommand mode: 'r'.
]

{ #category : #initialization }
IPKernelProxy >> startSubscriberProcessor [
	subscriber := IPIOSubscriberProcessor new: ioPub
]

{ #category : #utility }
IPKernelProxy >> stopKernel [
	"should execute stop command"
	LibC pipeClose: kernelPipe 

]

{ #category : #'message sends' }
IPKernelProxy >> wireMessage [
	^ wireMessage
]

{ #category : #'message sends' }
IPKernelProxy >> wireMessage: aWireMessage [
	"only for testing"
	wireMessage := aWireMessage
]
