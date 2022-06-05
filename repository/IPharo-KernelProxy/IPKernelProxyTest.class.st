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
	^ 20 seconds
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
	(Delay forMilliseconds: 300) wait.	
	
]

{ #category : #tests }
IPKernelProxyTest >> testClientWidget [
	| widget handler futureMsg response |
	handler := IPWidgetMsgHandler new. 
	kernelProxy addHandlerToIOSubscriber:  handler.
	widget := kernelProxy widgetFactory floatProgress. 
	widget setProperty: #value value: 5.0.

	futureMsg :=kernelProxy commMessageRequest: widget comm uuid  data: 
					{ #method-> #request_state.
						#target->'jupyter.widget' } asSCJsonObject.
	futureMsg 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ futureMsg isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	"still 5"
	self assert: widget value equals:5.

	
	
]

{ #category : #tests }
IPKernelProxyTest >> testExecuteRequest [
	| ipMsgResp code response|
	code := self sourceCode.
	kernelProxy 
		onExecuteResultPublishedDo: [ :aMessage| Transcript crShow:aMessage content asString ];
		onStreamPublishedDo: [ :aMessage| Transcript crShow:aMessage content asString ].
	ipMsgResp := kernelProxy executeRequest: code.
	ipMsgResp 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e | e inspect ].
	[ ipMsgResp isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	
	(Delay forMilliseconds:500) wait.
	self assert: response content status equals: #ok.

]

{ #category : #tests }
IPKernelProxyTest >> testKernelInfoRequest [
	| futureInfo response |
	futureInfo := kernelProxy kernelInfoRequest.
	futureInfo 
		onSuccessDo:[:r | response := r ];
		onFailureDo: [:e| e inspect].
	[ futureInfo isFinished ] whileFalse: [(Delay forMilliseconds:50) wait].
	self assert: response uuid notNil
]

{ #category : #tests }
IPKernelProxyTest >> testKernelWidget [
	| handler aFutureMsg response receivedMessages|
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
(Delay forMilliseconds: 1000) wait.
	self assert: receivedMessages isNotEmpty.

	
	
	
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
