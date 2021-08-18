"
I store the execution environment for a User, I implement playground variables, compile and evaluate the code. 

- I am a message factory, because all the answering messages need session information to build the wire message to the client. 

- I collaborate with IPComm and IPWidgets. 

 
Internal Representation and Key Implementation Points.

    Instance Variables
	bindings:		<Dictionary>, playground variables
	cachedObjects:	<Dictionary>, Bitmapped Objects are catched
	display:		<IPDisplay> is responsible of displaing complex object. 
	executionCounter:		<Integer>.
	id:		<Object> Session Id.
	startTime:		<Object> Session starting time.
	username:		<Object>
	widgetsFactory:		<IPWidgetFactory>


    Implementation Points
"
Class {
	#name : #IPSession,
	#superclass : #Object,
	#instVars : [
		'id',
		'username',
		'startTime',
		'executionCounter',
		'bindings',
		'cachedObjects',
		'display',
		'widgetsFactory',
		'currentMessage',
		'request',
		'sem'
	],
	#classInstVars : [
		'sessions'
	],
	#category : #'IPharo-Core'
}

{ #category : #accessing }
IPSession class >> finalizeSession: sessionId [
	self sessions removeKey: sessionId

]

{ #category : #accessing }
IPSession class >> finalizeSessions [
	self sessions removeAll

]

{ #category : #accessing }
IPSession class >> getSessionForMessage: aMessage [

	| session |
	session := self sessions at: (aMessage header session) ifAbsentPut:[
						self new 
							username: aMessage header username;
							id: aMessage header session;
							startTime: aMessage header timestamp ].
	session currentMessage:	aMessage.
	^ session						
	
		
									
]

{ #category : #accessing }
IPSession class >> session: aSessionId [
	
	^ self sessions at: aSessionId 


									
]

{ #category : #accessing }
IPSession class >> sessions [
	^ sessions ifNil:[ sessions := Dictionary new ]
]

{ #category : #visiting }
IPSession >> acceptInputReplay: content [
	request := content.
	sem signal
]

{ #category : #'workspace vars support' }
IPSession >> bindingOf: aString [ 
	(bindings includesKey: aString)
		ifFalse: [ bindings add: (WorkspaceVariable key: aString asSymbol) ].
	^ bindings associationAt: aString
]

{ #category : #accessing }
IPSession >> bindings [
	^ bindings
]

{ #category : #'message-comm' }
IPSession >> commCloseMessage [
	 | msg |
	msg := IPCommCloseMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #'message-comm' }
IPSession >> commMsgMessage [
	 | msg |
	msg := IPCommMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #'message-comm' }
IPSession >> commOpenMessage [
	 | msg |
	msg := IPCommOpenMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #'message-comm' }
IPSession >> commUpdateMessage [
	 | msg |
	msg := IPCommUpdateMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #compilation }
IPSession >> compileAndEvaluate: aMessage [
	| result executionResult dataModel |
	self display reset.
	result := self evaluate: aMessage content code.
	executionResult := self  executeResultMessage.
	dataModel := self display buildDisplayDataModel: result asString.
	executionResult content addAll: dataModel.	
	self display publish: executionResult.
	
	
]

{ #category : #'message-comm' }
IPSession >> completeReplyMsg [
	 | msg |
	msg := IPCompleteReplyMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #accessing }
IPSession >> currentMessage [

	^ currentMessage
]

{ #category : #accessing }
IPSession >> currentMessage: anObject [

	currentMessage := anObject
]

{ #category : #'public-api' }
IPSession >> defaultNumberOfRows [
	^ 100

	 
	
														
														
]

{ #category : #accessing }
IPSession >> display [
	^ display ifNil:[ display := IPDisplay onSession: self ]
]

{ #category : #'messages-iopub' }
IPSession >> displayDataMessage [
	 | msg |
	msg := IPDisplayDataMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.

	^ msg 
]

{ #category : #compilation }
IPSession >> evaluate: source [
	| result method |
	method := self class compiler
			source: source;
			noPattern: true;
			context: thisContext;
			failBlock:  [:err| ZmqLog logError:err messageText . ^ nil];
			compileDoit.
	result := method valueWithReceiver: self arguments: { thisContext }.		
	^  result 
			
	
]

{ #category : #'messages-iopub' }
IPSession >> executeErrorMessage [
	 | msg |
	msg := IPExecuteErrorMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #'messages-iopub' }
IPSession >> executeInputMessage [
	 | msg |
	msg := IPExecuteInputMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg executionCount:  executionCounter
	
																						
]

{ #category : #'messages-iopub' }
IPSession >> executeResultMessage [
	 | msg |
	msg := IPExecuteResultMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg executionCount:  executionCounter
]

{ #category : #'messages-shell' }
IPSession >> executionAbortedMessage [
	 | msg |
	msg := IPExecutionAbortedMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg executionCount:  self executionCounter
]

{ #category : #accessing }
IPSession >> executionCounter [
	^ executionCounter 
]

{ #category : #'messages-shell' }
IPSession >> executionErrorMessage [
	 | msg |
	msg := IPExecutionErrorMsg newReplyingToWireMessage: self currentMessage wireMessage.  
	self initializeMessageHeader: msg.
	^ msg executionCount:  self executionCounter
]

{ #category : #'messages-shell' }
IPSession >> executionOkMessage [
	 | msg |
	msg := IPExecutionOkMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	msg metadata engine: self id.
	self initializeMessageHeader: msg.
	^ msg executionCount:  self executionCounter
]

{ #category : #'workspace vars support' }
IPSession >> guessTypeForName: aString [
	| binding |
	bindings
		ifNotNil: [ 
			binding := bindings at: aString ifAbsent: [ nil ].
			binding isNil
				ifFalse: [ ^ binding class ] ].
	^ nil
]

{ #category : #'workspace vars support' }
IPSession >> hasBindingOf: aString [ 
	^(self guessTypeForName: aString) notNil
]

{ #category : #'workspace vars support' }
IPSession >> hasBindingThatBeginsWith: aString [
	^ bindings keys anySatisfy: [:each | each beginsWith: aString]
]

{ #category : #accessing }
IPSession >> id [
	^ id
]

{ #category : #accessing }
IPSession >> id: anObject [
	id := anObject
]

{ #category : #accessing }
IPSession >> increaseExecutionCounter [
	executionCounter := executionCounter + 1
]

{ #category : #initialization }
IPSession >> initialize [

	super initialize.
	self initializeBindings.
	executionCounter := 1.
	sem :=Semaphore new.
]

{ #category : #initialization }
IPSession >> initializeBindings [
	
	bindings := Dictionary new
]

{ #category : #initialization }
IPSession >> initializeMessageHeader: aMessage [
	"copy header from wire message, it could not be serialized from the IPMsg, jupyter client need to receive exactly the same bytes in parent header than the source wire message...so if you serialize, the order of the properties could not be the same so byte stream will not.
	All of the messages in a session are answering to an execute request message"
	aMessage header 
				session: self id;
				username: self kernelUsername.

	^ aMessage 
]

{ #category : #'messages-shell' }
IPSession >> kernelInfoReplayMessage [
	 | msg |
	msg := IPKernelInfoReplyMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #accessing }
IPSession >> kernelUsername [
	^#kernel
]

{ #category : #'public-api' }
IPSession >> loadScript: aStringScript [
	"used to load javascript in client side"
	self display injectScript:aStringScript

	
	 
	
														
														
]

{ #category : #accessing }
IPSession >> print: anObject [
	self display openInJupyter: anObject
]

{ #category : #'public-api' }
IPSession >> request: requestString [
	| msg |
	(self currentMessage content at:'allow_stdin') ifFalse:[ IPStdInNotSupportedByClient signal].
	msg := IPInputRequestMsg newReplyingToWireMessage: self currentMessage wireMessage.
	msg prompt: requestString.
	self initializeMessageHeader: msg.
	IPharoKernel instance stdin sendMessage: msg.
	"request should be written by #acceptInputReply from IPharoKernel instance stdin processor"
	sem wait.
	^ request
	
	
]

{ #category : #accessing }
IPSession >> selectedClassOrMetaClass [
	^ nil
]

{ #category : #'workspace vars support' }
IPSession >> setBindings: aDictionary [
	"Sets the Workspace to use the specified dictionary as its namespace"

	bindings := aDictionary.
]

{ #category : #accessing }
IPSession >> startTime [
	^ startTime
]

{ #category : #accessing }
IPSession >> startTime: anObject [
	startTime := anObject
]

{ #category : #'messages-iopub' }
IPSession >> updateDisplayMessage [
	 | msg |
	msg := IPUpdateDisplayDataMsg newReplyingToWireMessage: self currentMessage wireMessage. 
	self initializeMessageHeader: msg.
	^ msg 
]

{ #category : #accessing }
IPSession >> username [
	^ username
]

{ #category : #accessing }
IPSession >> username: anObject [
	username := anObject
]

{ #category : #'public-api' }
IPSession >> widgetsFactory [
	^ widgetsFactory ifNil:[widgetsFactory := IPWidgetFactory onSession: self]
]
