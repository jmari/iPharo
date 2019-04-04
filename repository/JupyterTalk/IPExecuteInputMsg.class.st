Class {
	#name : #IPExecuteInputMsg,
	#superclass : #IPMsg,
	#category : 'JupyterTalk-Messages-IOPub'
}

{ #category : #accessing }
IPExecuteInputMsg >> code: source [
	self content code: source
]

{ #category : #accessing }
IPExecuteInputMsg >> executionCount [
	^ self content execution_count
]

{ #category : #accessing }
IPExecuteInputMsg >> executionCount: anInteger [
	self content execution_count:anInteger
]

{ #category : #initialization }
IPExecuteInputMsg >> initialize [
	
	super initialize.
	self msgType: #execute_input.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	self content: SCJsonObject new.
]
