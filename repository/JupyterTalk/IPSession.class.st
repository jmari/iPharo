Class {
	#name : #IPSession,
	#superclass : #Object,
	#instVars : [
		'id',
		'username',
		'startTime',
		'timeout',
		'executionCounter',
		'executionProcess',
		'bindings',
		'cachedObjects',
		'display',
		'widgetsFactory',
		'tasks'
	],
	#classInstVars : [
		'currentSession'
	],
	#category : #'JupyterTalk-Core'
}

{ #category : #accessing }
IPSession class >> currentSession [
	^ currentSession value
]

{ #category : #accessing }
IPSession class >> finalizeSession [
	currentSession := nil
]

{ #category : #accessing }
IPSession class >> newSessionFor: aHeader [

	currentSession :=
			(aHeader session) -> (self new 
							username: aHeader username;
							id: aHeader session;
							startTime: aHeader timestamp).
							
	^ currentSession value
		
									
]

{ #category : #'instance creation' }
IPSession class >> session: sessionId [
	
	^ self currentSession ifNotNil:[self currentSession]


									
]

{ #category : #tests }
IPSession class >> testSession [
	currentSession :=
			'TEST' -> (self new 
							username: 'TEST';
							id: 'TEST';
							startTime: DateAndTime now).
	^ currentSession value
	
]

{ #category : #compilation }
IPSession >> bindingOf: aString [ 
	(bindings includesKey: aString)
		ifFalse: [ bindings add: (WorkspaceVariable key: aString asSymbol) ].
	^ bindings associationAt: aString
]

{ #category : #accessing }
IPSession >> bindings [
	^ bindings
]

{ #category : #'comm messages' }
IPSession >> commCloseMessage [
	 | msg |
	msg := IPCommCloseMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 
]

{ #category : #'comm messages' }
IPSession >> commMsgMessage [
	 | msg |
	msg := IPCommMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 
]

{ #category : #'comm messages' }
IPSession >> commOpenMessage [
	 | msg |
	msg := IPCommOpenMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 
]

{ #category : #'comm messages' }
IPSession >> commUpdateMessage [
	 | msg |
	msg := IPCommUpdateMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 
]

{ #category : #compilation }
IPSession >> compileAndEvaluate: aMessage [
	| result |
	self display reset.
	result := self evaluate: aMessage content code.
	self display hasJupyterData 
								ifFalse:[self display openInJupyter: result asString].
	
	
]

{ #category : #'debugger support' }
IPSession >> debug: aCompiledMethod in: evalContext [
	| guineaPig context debugSession |
	guineaPig := [ aCompiledMethod
		valueWithReceiver: self
		arguments: (evalContext ifNil: [ #() ] ifNotNil: [ {evalContext} ]) ]
		newProcess.
	context := guineaPig suspendedContext.
	
	debugSession := guineaPig newDebugSessionNamed: 'debug it' startedAt: context.
	debugSession stepIntoUntil: [:currentContext | 
		currentContext method == aCompiledMethod ].
	
	Smalltalk tools debugger openOn: debugSession withFullView: true.
	
]

{ #category : #'debugger support' }
IPSession >> debug: aCompiledMethod receiver: anObject in: evalContext [
	| guineaPig context debugSession |
	guineaPig := [ aCompiledMethod
		valueWithReceiver: anObject
		arguments: (evalContext ifNil: [ #() ] ifNotNil: [ {evalContext} ]) ]
		newProcess.
	context := guineaPig suspendedContext.
	
	debugSession := guineaPig newDebugSessionNamed: 'debug it' startedAt: context.
	debugSession stepIntoUntil: [:currentContext | 
		currentContext method == aCompiledMethod ].
	
	Smalltalk tools debugger openOn: debugSession withFullView: true.
	
]

{ #category : #'public-api' }
IPSession >> defaultNumberOfRows [
	^ 100

	 
	
														
														
]

{ #category : #accessing }
IPSession >> display [
	^ display ifNil:[display := IPDisplay new]
]

{ #category : #'iopub messages' }
IPSession >> displayDataMessage [
	 | msg |
	msg := IPDisplayDataMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.

	^ msg 
]

{ #category : #compilation }
IPSession >> doItContext [

	^  nil
	

]

{ #category : #compilation }
IPSession >> doItReceiver [

	^  self
	

]

{ #category : #compilation }
IPSession >> evaluate: source [

	| result rcvr ctxt |

	rcvr := self doItReceiver.
	ctxt := self doItContext. 

	[
	[result := rcvr class compiler
			source: source;
			context: ctxt;
			receiver: rcvr;
			requestor: self;
			failBlock:  [:err| ZmqLog logError:err msg . ^ nil];
			evaluate]
		on:Error do:[:e| 
				"We just need to chech for Error not Exception"
				result := e.
			]]  forkAndWait.		
		
	(result isKindOf: Error ) ifTrue:[result signal].

	^  result 
			
	
]

{ #category : #'iopub messages' }
IPSession >> executeErrorMessage [
	 | msg |
	msg := IPExecuteErrorMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg 
]

{ #category : #'iopub messages' }
IPSession >> executeInputMessage [
	 | msg |
	msg := IPExecuteInputMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  executionCounter
	
																						
]

{ #category : #'iopub messages' }
IPSession >> executeResultMessage [
	 | msg |
	msg := IPExecuteResultMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  executionCounter
]

{ #category : #'shell messages' }
IPSession >> executionAbortedMessage [
	 | msg |
	msg := IPExecutionAbortedMsg new.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  self executionCounter
]

{ #category : #accessing }
IPSession >> executionCounter [
	^ executionCounter 
]

{ #category : #'shell messages' }
IPSession >> executionErrorMessage [
	 | msg |
	msg := IPExecutionErrorMsg new. 
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  self executionCounter
]

{ #category : #'shell messages' }
IPSession >> executionOkMessage [
	 | msg |
	msg := IPExecutionOkMsg new.
	msg metadata engine: self id.
	msg header 
				session: self id;
				username: self kernelUsername.
	^ msg executionCount:  self executionCounter
]

{ #category : #accessing }
IPSession >> guessTypeForName: aString [
	| binding |
	bindings
		ifNotNil: [ 
			binding := bindings at: aString ifAbsent: [ nil ].
			binding isNil
				ifFalse: [ ^ binding class ] ].
	^ nil
]

{ #category : #compilation }
IPSession >> hasBindingOf: aString [ 
	^(self guessTypeForName: aString) notNil
]

{ #category : #compilation }
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
	executionCounter := 1.
	self initializeBindings
]

{ #category : #initialization }
IPSession >> initializeBindings [
	
	bindings := Dictionary new
]

{ #category : #'shell messages' }
IPSession >> kernelInfoReplayMessage [
	 | msg |
	msg := IPKernelInfoReplyMsg new. 
	msg uuid:'Ø'.
	msg header
				session: self id;
				username: self kernelUsername.
	^ msg 
]

{ #category : #accessing }
IPSession >> kernelUsername [
	^#kernel
]

{ #category : #'public-api' }
IPSession >> loadScript: aStringScript [

	self display injectScript:aStringScript

	
	 
	
														
														
]

{ #category : #accessing }
IPSession >> print: anObject [
	self display openInJupyter: anObject
]

{ #category : #accessing }
IPSession >> selectedClassOrMetaClass [
	^ nil
]

{ #category : #accessing }
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

{ #category : #compilation }
IPSession >> tasks [
	^tasks ifNil:[ tasks:= OrderedCollection new]
]

{ #category : #accessing }
IPSession >> timeout [
	^ timeout
]

{ #category : #accessing }
IPSession >> timeout: anObject [
	timeout := anObject
]

{ #category : #'iopub messages' }
IPSession >> updateDisplayMessage [
	 | msg |
	msg := IPUpdateDisplayDataMsg  new.
	msg header 
				session: self id;
				username: self kernelUsername.
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
	^ widgetsFactory ifNil:[widgetsFactory := IPWidgetFactory new]
]
