Class {
	#name : #IPInterruptErrorReplyMsg,
	#superclass : #IPInterruptReplyMsg,
	#instVars : [
		'exceptionObject'
	],
	#category : #'IPharo-Messages-Control'
}

{ #category : #'instance creation' }
IPInterruptErrorReplyMsg class >> newWithSequenceNumber: aSeqNum [ 
		self error:'use newWithSequenceNumber:anInteger error:anExceptionObject'
				
]

{ #category : #'instance creation' }
IPInterruptErrorReplyMsg class >> newWithSequenceNumber: aSeqNum error: AnException [
	^ self basicNew 
				executionCount: aSeqNum;
				exceptionObject: AnException;
				initialize
				
]

{ #category : #initialization }
IPInterruptErrorReplyMsg >> exceptionObject [
	^ exceptionObject 
]

{ #category : #initialization }
IPInterruptErrorReplyMsg >> exceptionObject: anException [
	exceptionObject := anException.
	self fillContent 
]

{ #category : #accessing }
IPInterruptErrorReplyMsg >> fillContent [

	self content at:#ename put: self exceptionObject className.
	self content at:#evalue put: self exceptionObject messageText asString.
	self content at:#traceback put: self traceback.
	
]

{ #category : #accessing }
IPInterruptErrorReplyMsg >> status [
	^ #error
]

{ #category : #'as yet unclassified' }
IPInterruptErrorReplyMsg >> traceback [
	|aStream|
	aStream := ReadWriteStream on:String new.
	aStream 
		nextPutAll: self exceptionObject asString;
		nextPutAll: String crlf.
	
	self exceptionObject signalerContext errorReportOn: aStream.

	^ aStream contents substrings: Character cr asString
]
