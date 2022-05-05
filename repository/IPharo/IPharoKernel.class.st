"
I'm the pharo kernel for Jupyter. I have a single instance created by IPharoCommandLineHandler, I need a configuration file passed as a first argument in the command line in order to configure all the ZmQ Sockets.
I have four processes, each of them has a Zmq socket as https://jupyter-client.readthedocs.io/en/latest/messaging.html describes. They are ""publisher"", ""shell"", ""control"", ""stdin"" and ""heartbeat"".

I keep the IPCommManager instance, it handles the communication with the widgets.   

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commManager:		<Object>
	config:		<Object>
	control:		<Object>
	heartbeat:		<Object>
	ioPub:		<Object>
	port:		<Object>
	processors:		<Object>
	sharedKey:		<Object>
	shell:		<Object>
	stdin:		<Object>
	stop:		<Object>


    Implementation Points
"
Class {
	#name : #IPharoKernel,
	#superclass : #Object,
	#instVars : [
		'heartbeat',
		'shell',
		'control',
		'stdin',
		'ioPub',
		'port',
		'stop',
		'processors',
		'sharedKey',
		'config',
		'commManager'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'IPharo-Core'
}

{ #category : #testing }
IPharoKernel class >> hasSupportForDebugger [
	^ true
]

{ #category : #'as yet unclassified' }
IPharoKernel class >> implementation [
	^ 'IPharo Smalltalk'
]

{ #category : #initialization }
IPharoKernel class >> initialize [
	"stops the kernel each time the image is stopped or saved"
	SessionManager default registerUserClassNamed: self name  atPriority: 100.

"installation script"

"create folder"
	'/usr/local/share/jupyter/kernels/pharo'.
"create file"
	'kernel.json'.
"with contents"
'{
  "argv": [
    "/PathToPharoExecutable/Pharo",
    "/PathToPharoImage/Pharo.image",
    "ipharo",
    "{connection_file}"
  ],
  "display_name": "Pharo Smalltalk",
  "language": "smalltalk"
}'.
"copy an icon with file name logo-64x64.png in the same folder"
'jupyter kernelspec install /path/to/kernel.json'
]

{ #category : #'instance creation' }
IPharoKernel class >> instance [
	^ instance ifNil:[ self new ]
	
]

{ #category : #'instance creation' }
IPharoKernel class >> isStarted [
	^ instance notNil and:[ instance processors isNotEmpty ]
	
]

{ #category : #'instance creation' }
IPharoKernel class >> new [
	instance ifNotNil:[instance stop].
	instance := self basicNew.
	instance initialize.
	^ instance
	
]

{ #category : #'as yet unclassified' }
IPharoKernel class >> protocolVersion [
	^ '5.0.0'
]

{ #category : #'system startup' }
IPharoKernel class >> shutDown [
	self instance stop.
	instance:=nil.

]

{ #category : #versions }
IPharoKernel class >> version [
	^ '1.0.0'
]

{ #category : #initialization }
IPharoKernel >> config [
	^ config 
]

{ #category : #initialization }
IPharoKernel >> config: kernelConfig [ 
	config := kernelConfig 
]

{ #category : #initialization }
IPharoKernel >> configureKernel: kernelConfig [
	sharedKey := (kernelConfig at:#key).
	heartbeat bind: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#hb_port)).
	stdin bind: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#stdin_port)).
	control bind:(self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#control_port)).
	shell bind: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#shell_port)).
	ioPub bind: (self connectionStringFor:(kernelConfig at:#transport)
								ip: (kernelConfig at:#ip)
								port: (kernelConfig at:#iopub_port)).
	self config: kernelConfig 
]

{ #category : #utility }
IPharoKernel >> connectionStringFor:transport ip:anIp port:aPort [
	^ transport asString , '://' , anIp asString, ':' ,aPort asString
]

{ #category : #processors }
IPharoKernel >> control [
	^ self processors at:#ctrl.
	
	

]

{ #category : #accessing }
IPharoKernel >> debug: anError [
	Transcript show: anError asString;cr
]

{ #category : #threads }
IPharoKernel >> heartbeatThread [
	[	|echoData|
	[
		[ self isStopping ] whileFalse:[
			echoData := heartbeat waitTilReceive. 
			heartbeat send: echoData asByteArray.
			Processor yield.
			(Delay forMilliseconds: 5000) wait]
	]on:Error do:[:e| self debug:e]
	] forkNamed:'ipharo-echo' 
]

{ #category : #initialization }
IPharoKernel >> initialize [
	super initialize.
	ZmqContext current.
	heartbeat := ZmqResponseSocket new.
	shell := ZmqRouterSocket new. 
	control := ZmqRouterSocket new. 
	stdin := ZmqRouterSocket new. 
	ioPub := ZmqPublisherSocket new.
	stop := false.

]

{ #category : #accessing }
IPharoKernel >> isStopping [
	^ stop 
]

{ #category : #accessing }
IPharoKernel >> port [
	^ port ifNil:[port := 171172]
]

{ #category : #accessing }
IPharoKernel >> port: anInteger [
	port := anInteger
]

{ #category : #'private-accessing' }
IPharoKernel >> processors [
	^ processors ifNil:[processors := Dictionary new]

]

{ #category : #processors }
IPharoKernel >> publisher [
	^  	self processors at:#iopub.
]

{ #category : #accessing }
IPharoKernel >> sharedKey [
	^ sharedKey ifNil:[0]
]

{ #category : #accessing }
IPharoKernel >> sharedKey: aSHA256keyInHex [
	sharedKey := aSHA256keyInHex
]

{ #category : #processors }
IPharoKernel >> shell [
	^ self processors at:#shell.

]

{ #category : #accessing }
IPharoKernel >> start [
 	self processors at:#shell put: (IPShellProcessor new: shell).
	self processors at:#ctrl put: (IPControlProcessor new:control).
	self processors at:#stdin put: (IPStdInProcessor new:stdin).
	self processors at:#iopub put: (IPIOPubProcessor new:ioPub).
	self heartbeatThread.
	IPSession finalizeSessions

]

{ #category : #processors }
IPharoKernel >> stdin [
	^ self processors at:#stdin.

	
	

]

{ #category : #accessing }
IPharoKernel >> stop [
	stop := true.
	self processors values do:[:each| each stop].
	self processors removeAll.
	IPSession finalizeSessions.
	IPDisplay resetCache.
	[ZmqContext terminate] on:Error do:[:e|].
	stop :=false
	 
]
