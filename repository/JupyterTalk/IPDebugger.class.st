Class {
	#name : #IPDebugger,
	#superclass : #Object,
	#category : #'JupyterTalk-Debuger'
}

{ #category : #'do-its' }
IPDebugger >> debug: aCompiledMethod receiver: anObject in: evalContext [
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
