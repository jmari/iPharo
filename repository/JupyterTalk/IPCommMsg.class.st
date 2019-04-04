Class {
	#name : #IPCommMsg,
	#superclass : #IPMsg,
	#category : 'JupyterTalk-Messages-Comm'
}

{ #category : #'as yet unclassified' }
IPCommMsg >> commID [
	^ self content at:#comm_id ifAbsentPut:[ self msgUUID ]
]

{ #category : #'as yet unclassified' }
IPCommMsg >> commID: aValue [
	self content at:#comm_id put: aValue
]

{ #category : #accessing }
IPCommMsg >> data [
	^ self content at:#data 
]

{ #category : #accessing }
IPCommMsg >> data: data [
	^ self content at:#data put: data
]

{ #category : #accessing }
IPCommMsg >> msgType [
	^ #comm_msg
]

{ #category : #'as yet unclassified' }
IPCommMsg >> targetName [
	^ self content at: #target_name 
]

{ #category : #'as yet unclassified' }
IPCommMsg >> targetName: aName [
	^ self content at:#target_name put: aName
]
