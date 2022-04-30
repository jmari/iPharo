Class {
	#name : #IPKernelProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #'system startup' }
IPKernelProxyTest >> setUp [
	kernelProxy := IPIPharoKernelProxy new
]

{ #category : #accessing }
IPKernelProxyTest >> sourceCode [
	^ 'a:=0.
	b:=1.
	c:=2'
]

{ #category : #'system startup' }
IPKernelProxyTest >> tearDown [
	kernelProxy stop
]

{ #category : #tests }
IPKernelProxyTest >> testKernelInfoRequest [
	| info |
	info := kernelProxy kernelInfoRequest.
	self assert:info content debugger equals: true
]

{ #category : #tests }
IPKernelProxyTest >> testWidget [
	| widget |
	kernelProxy addHandler:  IPMsgHandler new. 
	widget := kernelProxy session widgetFactory floatProgress. 
	widget setProperty: #value value: 5.0.
	(Delay forMilliseconds: 60000) wait.
	self assert: widget isNotNil.
	
	
]

{ #category : #tests }
IPKernelProxyTest >> testisCompleteRequest [
	| isCompleteMessage code |
	code :='a:=0'.
	isCompleteMessage := kernelProxy isCompleteRequest: code.
	self assert: isCompleteMessage content status equals: #complete.
	code :='a:=10.
	[a >= 0] whileTrue:['.
	isCompleteMessage := kernelProxy isCompleteRequest: code.
	self assert: isCompleteMessage content status equals: #invalid
]
