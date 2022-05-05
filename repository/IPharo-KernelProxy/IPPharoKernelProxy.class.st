Class {
	#name : #IPPharoKernelProxy,
	#superclass : #IPKernelProxy,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPPharoKernelProxy >> displayName [
	^ 'Pharo Smalltalk'
]

{ #category : #'as yet unclassified' }
IPPharoKernelProxy >> executableFileName [
	^ '/Users/Cat/Documents/Pharo/vms/90-x64/Pharo.app/Contents/MacOS/Pharo'
]

{ #category : #'as yet unclassified' }
IPPharoKernelProxy >> executableOptions [
	^ {'--headless'. '/Users/Cat/Documents/Pharo/images/iPharo/iPharo.image'. 'ipharo'. self connectionFileName}
]

{ #category : #'as yet unclassified' }
IPPharoKernelProxy >> language [
	^ 'smalltalk'
]

{ #category : #'as yet unclassified' }
IPPharoKernelProxy >> metadata [
	^ '{"debugger":true}'
]
