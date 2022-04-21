Class {
	#name : #IPXpythonKernelProxy,
	#superclass : #IPKernelProxy,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPXpythonKernelProxy >> displayName [
	^ 'Python 3.9 (XPython)'
]

{ #category : #'as yet unclassified' }
IPXpythonKernelProxy >> executableFileName [
	^ '/Users/Cat/anaconda3/envs/jupyterlab-debugger/bin/xpython'
]

{ #category : #'as yet unclassified' }
IPXpythonKernelProxy >> executableOptions [
	^ {'-f'. self connectionFileName}
]

{ #category : #'as yet unclassified' }
IPXpythonKernelProxy >> language [
	^ 'python'
]

{ #category : #'as yet unclassified' }
IPXpythonKernelProxy >> metadata [
	^ '{"debugger":true}'
]
