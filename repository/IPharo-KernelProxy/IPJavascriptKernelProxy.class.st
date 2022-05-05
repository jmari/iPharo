Class {
	#name : #IPJavascriptKernelProxy,
	#superclass : #IPKernelProxy,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPJavascriptKernelProxy >> displayName [
	^ 'JavaScript (Node.js)'
]

{ #category : #'as yet unclassified' }
IPJavascriptKernelProxy >> executableFileName [
	^ 'ijskernel'
]

{ #category : #'as yet unclassified' }
IPJavascriptKernelProxy >> executableOptions [
	^ {'--hide-undefined'. '--protocol=5.1'. self connectionFileName}
]

{ #category : #'as yet unclassified' }
IPJavascriptKernelProxy >> language [
	^ 'javascript'
]

{ #category : #'as yet unclassified' }
IPJavascriptKernelProxy >> metadata [
	^ 'nil'
]
