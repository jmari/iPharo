"
I am a Json object to store the configuration file, it specifies the socket addresses and ports and the shared key
"
Class {
	#name : #IPConnectionConfig,
	#superclass : #SCJsonObject,
	#classVars : [
		'initialPort'
	],
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #converting }
IPConnectionConfig >> asJson [
	^ SCSerializer serialize: self
]

{ #category : #initialization }
IPConnectionConfig >> initialize [ 
	super initialize.

	initialPort ifNil:[initialPort := 50000].
	"we need to set the shared key because wireMessage uses it"
	self 
		control_port: initialPort ;
		hb_port: initialPort + 1;
		iopub_port: initialPort + 2;
		shell_port: initialPort + 3;
		stdin_port: initialPort + 4;
		ip:'127.0.0.1';
		signature_scheme:'hmac-sha256';
		transport: 'tcp' ;
		key: (SHA256 hashMessage: self hash asString) hex.
	"for the next kernel proxy"
	initialPort := initialPort + 5.
]
