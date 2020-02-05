"
This class is for testing pourpose .  It implements the Jupyter client messaging protocol

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
	#name : #IPClient,
	#superclass : #Object,
	#instVars : [
		'heartbeat',
		'shell',
		'control',
		'stdin',
		'ioPub'
	],
	#category : #'JupyterTalk-Client'
}

{ #category : #utility }
IPClient >> connectionStringFor:transport ip:anIp port:aPort [
	^ transport asString , '://' , anIp asString, ':' ,aPort asString
]

{ #category : #hooks }
IPClient >> execute: aWireMessage [
	| message|

	message := IPMsg newFromWireMessage: aWireMessage.
		
	message msgType = #execute_replay ifTrue:[ self executeReplay: message].



]

{ #category : #'as yet unclassified' }
IPClient >> executeReplay: aIPMsg [
	aIPMsg printDirectlyToDisplay 
]

{ #category : #'as yet unclassified' }
IPClient >> executeRequest: aStringWithCode [
	| message |
	message := IPExecuteRequestMsg new.
	message code: aStringWithCode.
	self sendMessage: message.
	self waitForReplay 
	
]

{ #category : #initialization }
IPClient >> initialize [
	super initialize.

	ZmqContext current.
	self startKernel.
	self initializeClientPorts. 

]

{ #category : #initialization }
IPClient >> initializeClientPorts [
	| kernelConfig sharedKey |
	"heartbeat must respond to the Kernel Heartbeat
	 Client is a subscribet to ioPub, kernel is the publisher
	shell, control, stdin are Requesters"
	
	heartbeat := ZmqResponseSocket new.
	shell := ZmqRequestSocket new. 
	control := ZmqRequestSocket new. 
	stdin := ZmqRequestSocket new. 
	ioPub := ZmqSubscriberSocket new.
	
	kernelConfig := self kernelConfig.
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
	
]

{ #category : #accessing }
IPClient >> kernelConfig [
	| configuration kernelConfig |
	
	"change this String if you want to test other conditions"
	
	configuration := '{
  				"control_port": 50160,
  				"shell_port": 57503,
  				"transport": "tcp",
 				"signature_scheme": "hmac-sha256",
  				"stdin_port": 52597,
  				"hb_port": 42540,
  				"ip": "127.0.0.1",
  				"iopub_port": 40885,
  				"key": "a0436f6c-1916-498b-8eb9-e81ab9368e84"}'.
	kernelConfig := SCMaterializer materializeFromString: configuration.
	^ kernelConfig 
]

{ #category : #accessing }
IPClient >> messageDelimiter [ 
	^'<IDS|MSG>'
]

{ #category : #'initailize-release' }
IPClient >> sendMessage: anIPRequest [

	shell ifNotNil: [ 
		shell  
				send: anIPRequest uuid flags:ZmqApiConstants  zmqSendMore;
	 			send: self messageDelimiter asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: anIPRequest calculateHMAC hex asByteArray flags:ZmqApiConstants  zmqSendMore;
 				send: anIPRequest header flags:ZmqApiConstants  zmqSendMore;
				send: anIPRequest parentHeader flags:ZmqApiConstants  zmqSendMore;
 				send: anIPRequest metadata flags:ZmqApiConstants  zmqSendMore;
				send: anIPRequest content ]
]

{ #category : #utility }
IPClient >> startKernel [
	"starts the Kernel"
	IPharoKernel new 
					configureKernel: self kernelConfig;
					start.
]

{ #category : #'as yet unclassified' }
IPClient >> waitForReplay [ 
	
]
