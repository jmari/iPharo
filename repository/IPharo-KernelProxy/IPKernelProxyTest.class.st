Class {
	#name : #IPKernelProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #accessing }
IPKernelProxyTest class >> defaultTimeLimit [
	^ 10 asDuration
]

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
	(Delay forMilliseconds: 3000) wait.
	kernelProxy stop
]

{ #category : #tests }
IPKernelProxyTest >> testClientWidget [
	| widget handler|
	handler := IPWidgetMsgHandler new. 
	kernelProxy addHandler:  handler.
	widget := kernelProxy widgetFactory floatProgress. 
	widget setProperty: #value value: 5.0.

	kernelProxy commMessageRequest: widget comm uuid  data: 
					{ #method-> #request_state.
						#target->'jupyter.widget' } asSCJsonObject.
	(Delay forMilliseconds: 3000) wait.
	"still 5"
	self assert: widget value equals:5.

	
	
]

{ #category : #tests }
IPKernelProxyTest >> testKernelInfoRequest [
	| info |
	info := kernelProxy kernelInfoRequest.
	self assert:info content debugger equals: true
]

{ #category : #tests }
IPKernelProxyTest >> testKernelWidget [
	| widget handler |
	handler := IPWidgetMsgHandler new. 

	handler on:#comm_msg do:[:aMessage|
		aMessage inspect ].

	kernelProxy addHandler:  handler.
	kernelProxy executeRequest: '
	widget:=self widgetFactory intSlider
                                value:7;
                                min:0;
                                max:10;
                                step:1;
                                description:''Test'';
                                disabled:false;
                                continuousUpdate:false;
                                orientation:''horizontal'';
                                readout:true;
                                readoutFormat:''d''.'
	onSucceed:[ :am | am inspect ].
	(Delay forMilliseconds: 2000) wait.
	
	
	
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
