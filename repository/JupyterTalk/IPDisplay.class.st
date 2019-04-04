Class {
	#name : #IPDisplay,
	#superclass : #Object,
	#instVars : [
		'jupyterData',
		'interaction',
		'extent'
	],
	#classInstVars : [
		'cachedObjects'
	],
	#category : 'JupyterTalk-Display'
}

{ #category : #accessing }
IPDisplay class >> cachedObjects [
	^ cachedObjects ifNil:[cachedObjects := Dictionary new]
]

{ #category : #removing }
IPDisplay class >> resetCache [
	cachedObjects :=nil
]

{ #category : #'comm handlers' }
IPDisplay >> composeResponse: aResult [
	| currentWireMessage executionResult |
	currentWireMessage := (IPharoKernel instance processors at:#shell) wireMessage.
	executionResult := IPSession currentSession executeResultMessage 
													respondsToWireMessage: currentWireMessage;
													yourself.	
	executionResult content addAll: aResult.	
	self publish: executionResult.

]

{ #category : #accessing }
IPDisplay >> debug: anError [
	ZmqLog logDebug: anError asString 
]

{ #category : #'public-api' }
IPDisplay >> extent [
	"default extent"
	^  extent ifNil:[ extent :=  640@400 ].
	
	
]

{ #category : #'public-api' }
IPDisplay >> extent: aPoint [
	extent:= aPoint 
	
	
]

{ #category : #accessing }
IPDisplay >> hasJupyterData [
	^ jupyterData notNil
]

{ #category : #initialization }
IPDisplay >> initialize [
	super initialize.
	interaction := false
]

{ #category : #'as yet unclassified' }
IPDisplay >> injectScript: aStringScript [
	self jupyterData data at:'text/html' put:aStringScript.
	self jupyterData metadata: SCJsonObject new.
	self composeResponse: self jupyterData. 
	self reset.
	
]

{ #category : #accessing }
IPDisplay >> jupyterData [
	^ jupyterData ifNil:[
		jupyterData := SCJsonObject new.
		jupyterData at:#data put:SCJsonObject new.
		jupyterData].
]

{ #category : #'public-api' }
IPDisplay >> maxNumberOfRows [
	^ 500

	 
	
														
														
]

{ #category : #'public-api' }
IPDisplay >> openInJupyter: data [ 
	^ self openInJupyter: data compose:true
]

{ #category : #'public-api' }
IPDisplay >> openInJupyter: data compose: compose [
	|aJupyterData  uuid  |
	self reset.
	aJupyterData := (interaction and:[data respondsTo:#asJupyterInteractiveDataWithExtent:]) 
							ifTrue:[data asJupyterInteractiveDataWithExtent: self extent]
							ifFalse:[data asJupyterDataWithExtent: self extent].	
	self jupyterData data at:aJupyterData key put:aJupyterData value.
	self jupyterData metadata:{
 									aJupyterData key -> {
    															'width' -> self extent x.
    															'height' -> self extent y
 														 	} asSCJsonObject.
														} asSCJsonObject.
	uuid:= UUID new hex asString asUppercase.
	self jupyterData transient: {#display_id -> uuid} asSCJsonObject.
	self class cachedObjects 
						at:uuid put: {    #data-> data.
												#interactive-> interaction.
												#extent->self extent.
												#metadata ->self jupyterData metadata} asDictionary. 
	compose ifTrue:[self composeResponse: self jupyterData]. 
	^ uuid
]

{ #category : #'public-api' }
IPDisplay >> openInJupyter: data extent: aPoint [
	
	self extent: aPoint.
	^ self openInJupyter: data
]

{ #category : #'comm handlers' }
IPDisplay >> publish: anIPMsg [
		(IPharoKernel instance processors at:#iopub) publish:  anIPMsg
]

{ #category : #'public-api' }
IPDisplay >> refresh: anUUID [ 
	| cdata udm|

	cdata:= self class cachedObjects at:anUUID ifAbsent:[self error:'Object ', anUUID asString,' not found in jupyter kernel cache'].
	"get the old object and execute display again"
	(cdata at:#interactive) ifTrue:[self interactionOn].
	self extent: (cdata at:#extent). 
	self openInJupyter: (cdata at:#data) compose:false.
	udm := IPSession currentSession  updateDisplayMessage.
	udm content addAll: self jupyterData .	
	udm transient: {#display_id -> anUUID} asSCJsonObject.
	udm metadata: (cdata at:#metadata).
	udm respondsToWireMessage:(IPharoKernel instance processors at:#shell) wireMessage.
	self publish:udm.
	"we need to reset current output to avoid double response..."
	self reset.
	
]

{ #category : #accessing }
IPDisplay >> reset [
	jupyterData := nil
]
