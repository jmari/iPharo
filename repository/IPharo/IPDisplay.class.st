"
I represesent the jupyter answer box below the code box

My responsability is to serve an easy api for displaying any kind of objects

A IPSession includes me and makes me visible in the code execution context by sending self display.  

Public API and Key Messages

- extent: aPoint  
- openInJupyter: anObject 
- openInJupyter: anObject extent: aPoint
- refresh: anObjectUUID


There is one instance of myself in each IPSession. Thats why I can only be created by #onSession:IPSession.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	extent:		<Point> 640@400 by default
	hasAlreadyPublished:		<Boolean> indicates that you have used the display to show a result, so that IPSession should not publish the output of the block code.
	interaction:		<Boolean> indicates that the output object shoud be interactive (used in roassal interactive html canvas)
	session:		<IPSession> owner session


    Implementation Points
"
Class {
	#name : #IPDisplay,
	#superclass : #Object,
	#instVars : [
		'interaction',
		'extent',
		'session',
		'hasBeenAlreadyPublished'
	],
	#classInstVars : [
		'cachedObjects'
	],
	#category : #'IPharo-Display'
}

{ #category : #accessing }
IPDisplay class >> cachedObjects [
	^ cachedObjects ifNil:[cachedObjects := Dictionary new]
]

{ #category : #'instance creation' }
IPDisplay class >> new [
	self error: 'Instance should be created using onSession:'
]

{ #category : #'as yet unclassified' }
IPDisplay class >> onSession: aIPSession [
	^ self basicNew 
				initialize;
				session: aIPSession
]

{ #category : #removing }
IPDisplay class >> resetCache [
	cachedObjects :=nil
]

{ #category : #builder }
IPDisplay >> buildDisplayDataModel: data [
	| aJupyterData  uuid dataModel |

	dataModel := self getDataModel. 
	aJupyterData := (interaction and:[data respondsTo:#asJupyterInteractiveDataWithExtent:]) 
							ifTrue:[data asJupyterInteractiveDataWithExtent: self extent]
							ifFalse:[data asJupyterDataWithExtent: self extent].	
	dataModel data at:aJupyterData key put:aJupyterData value.
	dataModel metadata:{
 						aJupyterData key -> {
    									'width' -> self extent x.
    									'height' -> self extent y } asSCJsonObject.
										} asSCJsonObject.
	uuid:= UUID new hex asString asUppercase.
	dataModel transient: {#display_id -> uuid} asSCJsonObject.
	self class cachedObjects 
						at:uuid put: {    #data-> data.
												#interactive-> interaction.
												#extent->self extent.
												#metadata ->dataModel metadata} asDictionary. 
	^ dataModel
]

{ #category : #accessing }
IPDisplay >> debug: anString [
	"store an error message in the log"
	ZmqLog logDebug: anString asString  
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
IPDisplay >> getDataModel [
	
	| dataModel |
	dataModel := SCJsonObject new.
	dataModel at:#data put:SCJsonObject new.
	^ dataModel.
]

{ #category : #state }
IPDisplay >> hasBeenAlreadyPublished [
	^ hasBeenAlreadyPublished
]

{ #category : #initialization }
IPDisplay >> initialize [
	super initialize.
	self reset.
]

{ #category : #'public-api' }
IPDisplay >> injectScript: aStringScript [

	| dataModel executionResult |
	dataModel := self getDataModel.
	dataModel data at:'text/html' put:aStringScript.
	dataModel metadata: SCJsonObject new.
	executionResult := self session executeResultMessage.
	executionResult content addAll: dataModel.	
	self publish: executionResult.
 
	
	
]

{ #category : #state }
IPDisplay >> interactionOn [
	interaction := true
]

{ #category : #'public-api' }
IPDisplay >> maxNumberOfRows [
	^ 500

	 
	
														
														
]

{ #category : #'public-api' }
IPDisplay >> openInJupyter: data [ 
	| dataModel displayData |
	
	hasBeenAlreadyPublished := false.
	dataModel := self buildDisplayDataModel: data.
	displayData  := self session displayDataMessage.
	displayData content addAll: dataModel deepCopy.
	self publish: displayData.
	"returns the UUID"
	^ dataModel transient display_id 
]

{ #category : #'public-api' }
IPDisplay >> openInJupyter: data extent: aPoint [
	
	self extent: aPoint.
	^ self openInJupyter: data
]

{ #category : #'comm handlers' }
IPDisplay >> publish: anIPMsg [
	
	IPharoKernel instance publisher publish:  anIPMsg.
	hasBeenAlreadyPublished := true.
]

{ #category : #'public-api' }
IPDisplay >> refresh: anUUID [ 
	| cdata updateDisplayMessage dataModel |

	cdata:= self class cachedObjects 
		at:anUUID 
		ifAbsent:[ self error:'Object ', anUUID asString,' not found' ].
	"get the old object and execute display again"
	(cdata at:#interactive) ifTrue:[ self interactionOn ].
	self extent: (cdata at:#extent). 
	dataModel := self buildDisplayDataModel: (cdata at:#data).
	updateDisplayMessage := self session updateDisplayMessage.
	updateDisplayMessage content addAll: dataModel.	
	updateDisplayMessage transient: {#display_id -> anUUID} asSCJsonObject.
	updateDisplayMessage metadata: (cdata at:#metadata).
	self publish: updateDisplayMessage.
	
	
]

{ #category : #state }
IPDisplay >> reset [
	hasBeenAlreadyPublished := false.
	interaction := false
]

{ #category : #accessing }
IPDisplay >> session [

	^ session
]

{ #category : #accessing }
IPDisplay >> session: anObject [

	session := anObject
]
