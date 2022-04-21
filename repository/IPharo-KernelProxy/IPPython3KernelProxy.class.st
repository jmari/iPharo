Class {
	#name : #IPPython3KernelProxy,
	#superclass : #IPKernelProxy,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> displayName [
	^ 'Python 3 (ipykernel)'
]

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> executableFileName [
	^ '/Users/Cat/anaconda3/envs/jupyterlab-debugger/bin/python'
]

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> executableOptions [
	^ {'-m'. 'ipykernel_launcher'. '-f'. self connectionFileName}
]

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> language [
	^ 'python'
]

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> metadata [
	^ '{"debugger":true}'
]
