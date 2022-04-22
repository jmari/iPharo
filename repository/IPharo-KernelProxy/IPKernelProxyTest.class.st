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
