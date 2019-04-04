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
	#category : 'JupyterTalk-Core'
}

{ #category : #'as yet unclassified' }
IPharoKernel class >> implementation [
	^ 'IPharo Smalltalk'
]

{ #category : #initialization }
IPharoKernel class >> initialize [
"by now we need to stop the kernel each time the image is stopped or saved"
	SessionManager default registerUserClassNamed: self name  atPriority: 100.
self flag: #todo.
"installation script"

"create folder"
	'/usr/local/share/jupyter/kernels/pharo'.
"create file"
	'kernel.json'.
"with contents"
'{
  "argv": [
    "/Applications/Pharo6.1-64_ZeroMQ.app/Contents/MacOS/Pharo",
    "/Applications/Pharo6.1-64_ZeroMQ.app/Contents/Resources/Pharo6.1-64.image",
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
	^ instance ifNil:[self new]
	
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
	(Delay forSeconds:1) wait
]

{ #category : #versions }
IPharoKernel class >> version [
	^ '0.1.0'
]

{ #category : #'comm handlers' }
IPharoKernel >> commManager [
	^ commManager ifNil:[commManager := IPCommManager new ]
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
IPharoKernel >> configKernel: kernelConfig [
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

{ #category : #accessing }
IPharoKernel >> debug: anError [
	Transcript show: anError asString;cr
]

{ #category : #threads }
IPharoKernel >> heartbeatThread [
	[	|echoData|
	[
		[ self isStopping ] whileFalse:[
			echoData := heartbeat receiveAndWait. 
			heartbeat send: echoData asByteArray]
	]on:Error do:[:e| self debug:e]
	] forkNamed:'ipharo-echo' 
]

{ #category : #initialization }
IPharoKernel >> initialize [
	super initialize.
	ZmqContext current.
	heartbeat := ZmqRequestSocket new.
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

{ #category : #accessing }
IPharoKernel >> processors [
	^ processors ifNil:[processors := Dictionary new]

]

{ #category : #accessing }
IPharoKernel >> sharedKey [
	^ sharedKey ifNil:[0]
]

{ #category : #accessing }
IPharoKernel >> start [
 	self processors at:#shell put: (IPShellProcessor new: shell).
	self processors at:#ctrl put: (IPControlProcessor new:control).
	self processors at:#stdin put: (IPStdInProcessor new:stdin).
	self processors at:#iopub put: (IPIOPubProcessor new:ioPub).
	self heartbeatThread.
	IPSession finalizeSession

]

{ #category : #accessing }
IPharoKernel >> stop [
	stop := true.
	self processors values do:[:each| each stop].
	self processors removeAll.
	self commManager commChannels removeAll.
	IPDisplay resetCache.
	[ZmqContext terminate] on:Error do:[:e|].
	stop :=false
	 
]
