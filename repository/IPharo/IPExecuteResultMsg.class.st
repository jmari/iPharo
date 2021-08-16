Class {
	#name : #IPExecuteResultMsg,
	#superclass : #IPDisplayDataMsg,
	#category : #'IPharo-Messages-IOPub'
}

{ #category : #'as yet unclassified' }
IPExecuteResultMsg >> executionCount [
	^ self content execution_count
]

{ #category : #'as yet unclassified' }
IPExecuteResultMsg >> executionCount: anInteger [
	self content execution_count: anInteger
]

{ #category : #accessing }
IPExecuteResultMsg >> msgType [
	^ #execute_result
]
