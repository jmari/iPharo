Class {
	#name : #IPUpdateDisplayDataMsg,
	#superclass : #IPDisplayDataMsg,
	#category : 'JupyterTalk-Messages-IOPub'
}

{ #category : #accessing }
IPUpdateDisplayDataMsg >> msgType [
	^ #update_display_data
]
