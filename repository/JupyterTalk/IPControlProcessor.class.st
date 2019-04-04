Class {
	#name : #IPControlProcessor,
	#superclass : #IPShellProcessor,
	#category : 'JupyterTalk-Core'
}

{ #category : #accessing }
IPControlProcessor >> threadName [
	^ 'ipharo-control' 
]
