Class {
	#name : #IPCoreWidgetModelGenerator,
	#superclass : #SCJsonObject,
	#category : #'JupyterTalk-Widgets'
}

{ #category : #versions }
IPCoreWidgetModelGenerator class >> majorVersion [
	^ 2
]

{ #category : #versions }
IPCoreWidgetModelGenerator class >> minorVersion [
	^ 0
]

{ #category : #'as yet unclassified' }
IPCoreWidgetModelGenerator class >> modelName [
	^self subclassResponsibility 
]

{ #category : #versions }
IPCoreWidgetModelGenerator class >> moduleName [
	^ '@jupyter-widgets/controls'
]

{ #category : #versions }
IPCoreWidgetModelGenerator class >> version [
	^ '1.4.0'
]

{ #category : #'as yet unclassified' }
IPCoreWidgetModelGenerator class >> viewName [
	^self subclassResponsibility 
]

{ #category : #accessing }
IPCoreWidgetModelGenerator >> state [

	^  (self at:#state )
]
