"
I am a Json object to store the configuration file, it specifies the socket addresses and ports and the shared key.

In the future...
zmq::context_t context(1);
zmq::socket_t sock(context, ZMQ_REP);
char port[1024]; //make this sufficiently large. 
                 //otherwise an error will be thrown because of invalid argument. 
size_t size = sizeof(port);
try{
    sock.bind(""tcp://*:*"");
}
catch (zmq::error_t&e ){
    cerr << ""couldn't bind to socket: "" << e.what();
    return e.num();
}
sock.getsockopt( ZMQ_LAST_ENDPOINT, &port, &size );
cout << ""socket is bound at port "" << port << endl;
"
Class {
	#name : #IPConnectionConfig,
	#superclass : #SCJsonObject,
	#classVars : [
		'InitialPort'
	],
	#classInstVars : [
		'defaultFirstPort'
	],
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #accessing }
IPConnectionConfig class >> defaultFirstPort [
	^ defaultFirstPort ifNil:[ defaultFirstPort:=50000 ]
]

{ #category : #accessing }
IPConnectionConfig class >> defaultFirstPort: anInteger [
	defaultFirstPort := anInteger
]

{ #category : #converting }
IPConnectionConfig >> asJson [
	^ SCSerializer serialize: self
]

{ #category : #initialization }
IPConnectionConfig >> initialize [ 
	super initialize.
	(self class allInstances size = 1 | InitialPort isNil) ifTrue:[InitialPort := self class defaultFirstPort].
	"we need to set the shared key because wireMessage uses it"
	self 
		control_port: InitialPort ;
		hb_port: InitialPort + 1;
		iopub_port: InitialPort + 2;
		shell_port: InitialPort + 3;
		stdin_port: InitialPort + 4;
		ip:'127.0.0.1';
		signature_scheme:'hmac-sha256';
		transport: 'tcp' ;
		key: (SHA256 hashMessage: self hash asString) hex.
	"for the next kernel proxy"
	InitialPort := InitialPort + 5.
]
