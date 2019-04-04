Class {
	#name : #IPTextModel,
	#superclass : #IPLabelModel,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'instance creation' }
IPTextModel class >> modelName [
	^ 'TextModel'
]

{ #category : #'instance creation' }
IPTextModel class >> viewName [
	^ 'TextView'
]
