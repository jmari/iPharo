Class {
	#name : #IPCommUpdateMsg,
	#superclass : #IPMsg,
	#category : 'JupyterTalk-Messages-Comm'
}

{ #category : #'as yet unclassified' }
IPCommUpdateMsg >> commID [
	^ self content at:#comm_id ifAbsentPut:[ self msgUUID ]
]

{ #category : #'as yet unclassified' }
IPCommUpdateMsg >> commID: aValue [
	self content at:#comm_id put: aValue
]

{ #category : #accessing }
IPCommUpdateMsg >> data [

	^  self content at:#data ifAbsentPut:[
		{	#method->#update.
			#state->nil.
			#buffer_paths:nil} asSCJsonObject ].

]

{ #category : #initialization }
IPCommUpdateMsg >> initialize [	
	super initialize.
	self data
]

{ #category : #accessing }
IPCommUpdateMsg >> msgType [
	^ #update
]

{ #category : #accessing }
IPCommUpdateMsg >> state: aModelState [

	self data at:#state put:aModelState
	

]
