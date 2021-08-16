Class {
	#name : #IPDisplayDataMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-IOPub'
}

{ #category : #initialization }
IPDisplayDataMsg >> contentMetadata [
	^ self content metadata
   
]

{ #category : #initialization }
IPDisplayDataMsg >> contentMetadata: aJsonMetadata [
	self content metadata: aJsonMetadata
   
]

{ #category : #initialization }
IPDisplayDataMsg >> data [
	^ self content data
   
]

{ #category : #initialization }
IPDisplayDataMsg >> data: aJsonData [
	self content data: aJsonData
   
]

{ #category : #accessing }
IPDisplayDataMsg >> msgType [
	^#display_data
]

{ #category : #initialization }
IPDisplayDataMsg >> transient [
	^ self content transient
   
]

{ #category : #initialization }
IPDisplayDataMsg >> transient: aJsonData [
	self content transient: aJsonData
   
]
