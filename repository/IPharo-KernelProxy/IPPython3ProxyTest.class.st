Class {
	#name : #IPPython3ProxyTest,
	#superclass : #TestCase,
	#instVars : [
		'kernelProxy'
	],
	#category : #'IPharo-KernelProxy-Test'
}

{ #category : #accessing }
IPPython3ProxyTest class >> defaultTimeLimit [
	^ 10 asDuration
]

{ #category : #'system startup' }
IPPython3ProxyTest >> setUp [
	kernelProxy := IPPython3KernelProxy new
]

{ #category : #accessing }
IPPython3ProxyTest >> sourceCode [
	^ 'a:=0.
	b:=1.
	c:=2'
]

{ #category : #'system startup' }
IPPython3ProxyTest >> tearDown [
	(Delay forMilliseconds: 3000) wait.
	kernelProxy stop
]

{ #category : #tests }
IPPython3ProxyTest >> testClientWidget [
	| widget handler|
	handler := IPWidgetMsgHandler new. 
	kernelProxy addHandler:  handler.
	widget := kernelProxy widgetFactory floatProgress. 
	widget setProperty: #value value: 5.0.

	kernelProxy commMessageRequest: widget comm uuid  data: 
					{ #method-> #request_state.
						#target->'jupyter.widget' } asSCJsonObject.
	(Delay forMilliseconds: 1000) wait.
	"still 5"
	self assert: widget value equals:5.

	
	
]

{ #category : #tests }
IPPython3ProxyTest >> testKernelInfoRequest [
	| info |
	info := kernelProxy kernelInfoRequest.
	self assert:info content status equals: 'ok'
]

{ #category : #tests }
IPPython3ProxyTest >> testKernelWidget [
	| widget handler |
	handler := IPWidgetMsgHandler new. 
	handler on:#comm_msg do:[:aMessage | aMessage session inspect ].
	kernelProxy addHandler:  handler.
	kernelProxy executeRequest: 'import ipywidgets as widgets
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
w.disabled = True'
onSucceed:[ :am | kernelProxy session inspect ].
(Delay forMilliseconds: 1000) wait.

]

{ #category : #tests }
IPPython3ProxyTest >> testisCompleteRequest [
	| isCompleteMessage code |
	code :='a=0'.
	isCompleteMessage := kernelProxy isCompleteRequest: code.
	self assert: isCompleteMessage content status equals: #complete.
	code :='a = 1
while a < 6:'.
	isCompleteMessage := kernelProxy isCompleteRequest: code.
	self assert: isCompleteMessage content status equals: #incomplete
]
