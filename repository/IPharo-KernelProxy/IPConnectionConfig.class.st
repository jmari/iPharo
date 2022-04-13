Class {
	#name : #IPConnectionConfig,
	#superclass : #SCJsonObject,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #converting }
IPConnectionConfig >> asJson [
	^ SCSerializer serialize: self
]

{ #category : #initialization }
IPConnectionConfig >> initialize [ 
	super initialize.
	"we need to set the shared key because wireMessage uses it"
	IPharoKernel instance sharedKey:(SHA256 hashMessage: 'put a uuid here') hex.
	self 
		control_port:50160;
		hb_port:42540;
		iopub_port: 40885;
		shell_port:57503;
		stdin_port:52597;
		ip:'127.0.0.1';
		signature_scheme:'hmac-sha256';
		transport: 'tcp' ;
		key: IPharoKernel instance sharedKey
]
