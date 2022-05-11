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
	kernelProxy := IPIPharoKernelProxy new.

]

{ #category : #accessing }
IPKernelProxyTest >> sourceCode [
	^ 'a:=0.
	b:=1.
	c:=2'
]

{ #category : #'system startup' }
IPKernelProxyTest >> tearDown [
	kernelProxy stop.
	"give him time to receive the shutDown message"
	(Delay forMilliseconds: 3000) wait.	
]

{ #category : #tests }
IPKernelProxyTest >> testClientWidget [
	| widget handler|
	handler := IPWidgetMsgHandler new. 
	kernelProxy addHandlerToIOSubscriber:  handler.
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
	(Delay forMilliseconds: 5000) wait.
	info inspect.
	self assert:info uuid notNil
]

{ #category : #tests }
IPKernelProxyTest >> testKernelWidget [
	| widget handler aFutureMsg response receivedMessages|
	receivedMessages := OrderedCollection new.
	handler := IPWidgetMsgHandler new. 
	handler onMessage:#comm_msg do:[:aMessage|
		receivedMessages add:aMessage  ].
	kernelProxy addHandlerToIOSubscriber:  handler.
	aFutureMsg := kernelProxy executeRequest: '
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
                                readoutFormat:''d''.'.
	aFutureMsg  
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e signal].
	[ aFutureMsg isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	response inspect.
	(Delay forMilliseconds: 2000) wait.
	
	
	
]

{ #category : #tests }
IPKernelProxyTest >> testisCompleteInvalidRequest [
	| isCompleteMessage code response|
		
	code :='a:=10.
	[a >= 0] whileTrue:['.
	isCompleteMessage := kernelProxy isCompleteRequest: code.
	isCompleteMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e | e inspect ].
	[ isCompleteMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response content status equals: #invalid
]

{ #category : #tests }
IPKernelProxyTest >> testisCompleteRequest [
	| isCompleteMessage code response|
	code :='a:=0'.
	isCompleteMessage := kernelProxy isCompleteRequest: code.
	isCompleteMessage 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ isCompleteMessage isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	
		
	self assert: response content status equals: #complete.
	
]
