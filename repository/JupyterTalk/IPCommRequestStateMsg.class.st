Class {
	#name : #IPCommRequestStateMsg,
	#superclass : #IPMsg,
	#category : 'JupyterTalk-Messages-Comm'
}

{ #category : #'as yet unclassified' }
IPCommRequestStateMsg >> commID [
	^ self content at:#comm_id ifAbsentPut:[ self msgUUID ]
]

{ #category : #'as yet unclassified' }
IPCommRequestStateMsg >> commID: aValue [
	self content at:#comm_id put: aValue
]

{ #category : #accessing }
IPCommRequestStateMsg >> data [
	^ self content at:#data 
]

{ #category : #initialization }
IPCommRequestStateMsg >> initialize [	
	super initialize.
	self data
]

{ #category : #accessing }
IPCommRequestStateMsg >> msgType [
	^ #request_state
]
