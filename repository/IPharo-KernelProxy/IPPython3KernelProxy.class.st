Class {
	#name : #IPPython3KernelProxy,
	#superclass : #IPKernelProxy,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> displayName [
	^ 'Python 3'
]

{ #category : #'as yet unclassified' }
IPPython3KernelProxy >> executableFileName [
	^ '/Users/Cat/anaconda3/bin/python'
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
	^ 'nil'
]
