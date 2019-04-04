Class {
	#name : #IPStdInProcessor,
	#superclass : #IPMessageProcessor,
	#category : 'JupyterTalk-Core'
}

{ #category : #hooks }
IPStdInProcessor >> execute: anIPMessage [
	"TODO: What do we have to do here¿?¿ we will see"
]

{ #category : #accessing }
IPStdInProcessor >> threadName [
	^ 'ipharo-stdin' 
]
