Class {
	#name : #IPExecutionErrorMsg,
	#superclass : #IPExecuteRequestReplayMsg,
	#instVars : [
		'exceptionObject'
	],
	#category : #'IPharo-Messages-Shell'
}

{ #category : #'instance creation' }
IPExecutionErrorMsg class >> newWithSequenceNumber: aSeqNum [ 
		self error:'use newWithSequenceNumber:anInteger error:anExceptionObject'
				
]

{ #category : #'instance creation' }
IPExecutionErrorMsg class >> newWithSequenceNumber: aSeqNum error: AnException [
	^ self basicNew 
				executionCount: aSeqNum;
				exceptionObject: AnException;
				initialize
				
]

{ #category : #initialization }
IPExecutionErrorMsg >> exceptionObject [
	^ exceptionObject 
]

{ #category : #initialization }
IPExecutionErrorMsg >> exceptionObject: anException [
	exceptionObject := anException.
	self fillContent 
]

{ #category : #accessing }
IPExecutionErrorMsg >> fillContent [

	self content at:#ename put: self exceptionObject className.
	self content at:#evalue put: self exceptionObject messageText asString.
	self content at:#traceback put: self traceback.
	
]

{ #category : #accessing }
IPExecutionErrorMsg >> status [
	^ #error
]

{ #category : #'as yet unclassified' }
IPExecutionErrorMsg >> traceback [
	|aStream|
	aStream := ReadWriteStream on:String new.
	aStream 
		nextPutAll: self exceptionObject asString;
		nextPutAll: String crlf.
	
	self exceptionObject signalerContext errorReportOn: aStream.

	^ aStream contents substrings: Character cr asString
]
