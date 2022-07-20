Class {
	#name : #IPXpythonKernelProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #accessing }
IPXpythonKernelProxyTest class >> defaultTimeLimit [
	^ 10 seconds
]

{ #category : #'system startup' }
IPXpythonKernelProxyTest >> setUp [
	kernelProxy := IPXpythonKernelProxy new.

]

{ #category : #accessing }
IPXpythonKernelProxyTest >> sourceCode [
	^ 'a:=0.
	b:=1.
	c:=2'
]

{ #category : #'system startup' }
IPXpythonKernelProxyTest >> tearDown [
	kernelProxy stop.
	"give him time to receive the shutDown message"
	(Delay forMilliseconds: 300) wait.	
]

{ #category : #tests }
IPXpythonKernelProxyTest >> testClientWidget [
	| widget handler response |
	handler := IPWidgetMsgHandler new. 
	kernelProxy addHandlerToIOSubscriber:  handler.
	widget := kernelProxy widgetFactory floatProgress. 
	widget setProperty: #value value: 5.0.

	response :=kernelProxy commMessageRequest: widget comm uuid  data: 
					{ #method-> #request_state.
						#target->'jupyter.widget' } asSCJsonObject.

	"still 5"
	self assert: widget value equals:5.
]

{ #category : #tests }
IPXpythonKernelProxyTest >> testExecuteRequest [
	| code response|
	code :='a=0'.
	response := kernelProxy executeRequest: code.
		
	self assert: (response content status ) equals: #ok.
]

{ #category : #tests }
IPXpythonKernelProxyTest >> testKernelInfoRequest [
	| response |
	response := kernelProxy kernelInfoRequest.
	self assert: response uuid notNil
]

{ #category : #tests }
IPXpythonKernelProxyTest >> testKernelWidget [
	| handler response receivedMessages|
	receivedMessages := OrderedCollection new.
	handler := IPWidgetMsgHandler new. 
	handler onMessage:#comm_msg do:[:aMessage|
		receivedMessages add:aMessage.
		aMessage inspect  ].
	kernelProxy addHandlerToIOSubscriber:  handler.
	response := kernelProxy executeRequest: 'import ipywidgets as widgets
w = widgets.IntSlider(
	value = 7,
	min = 0,
	max = 10,
	step =1,
	description = ''Test'',
	disabled = False,
	continuousUpdate = False,
	orientation = ''horizontal'',
	readout = True,
	readoutFormat =''d'',
)
w.value=5
w.disabled = True
display(w)'.

	self assert: receivedMessages isNotEmpty.

	
	
	
]

{ #category : #tests }
IPXpythonKernelProxyTest >> testisCompleteInvalidRequest [
	| code response|
		
	code :='a=10.
	while a >= 0:'.
	response := kernelProxy isCompleteRequest: code.

	self assert: response content status equals: #incomplete
]

{ #category : #tests }
IPXpythonKernelProxyTest >> testisCompleteRequest [
	| code response|
	code :='a=0'.
	response := kernelProxy isCompleteRequest: code.
		
	self assert: response content status equals: #complete.
	
]
