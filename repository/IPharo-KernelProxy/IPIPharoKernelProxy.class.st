Class {
	#name : #IPIPharoKernelProxy,
	#superclass : #IPKernelProxy,
	#category : #'IPharo-KernelProxy-Core'
}

{ #category : #'as yet unclassified' }
IPIPharoKernelProxy >> displayName [

	^ 'iPharo'
]

{ #category : #'as yet unclassified' }
IPIPharoKernelProxy >> executableFileName [

	^ FileLocator vmBinary fullName
]

{ #category : #'as yet unclassified' }
IPIPharoKernelProxy >> executableOptions [

	 ^ {	"'--headless'. "
			FileLocator image fullName. 
			'ipharo'. 
			self connectionFileName }
]

{ #category : #accessing }
IPIPharoKernelProxy >> language [

	"returns the language"

	'Smalltalk'
]

{ #category : #accessing }
IPIPharoKernelProxy >> metadata [

	"returns an array of metadata"

	'"debugger": true'
]
