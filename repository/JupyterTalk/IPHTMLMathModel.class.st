Class {
	#name : #IPHTMLMathModel,
	#superclass : #IPHTMLModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPHTMLMathModel class >> modelName [
	^ 'HTMLMathModel'
]

{ #category : #'instance creation' }
IPHTMLMathModel class >> viewName [
	^ 'HTMLMathView'
]
