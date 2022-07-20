Class {
	#name : #IPWidgetMsgHandler,
	#superclass : #IPMsgHandler,
	#instVars : [
		'register'
	],
	#category : #'IPharo-KernelProxy-MessageHandling'
}

{ #category : #'message-handlers' }
IPWidgetMsgHandler >> commCloseHandler: anIPMessage [
	<ipharo: #comm_close>
	| data comm |

	comm :=(anIPMessage session commManager commChannelAt:(anIPMessage content at:#comm_id)). 
	data := anIPMessage content at:#data.
	comm data: data.
	comm commListeners do:[:l| l onDataReceived: data ].
	anIPMessage session commManager unregisterComm: (anIPMessage content at:#comm_id).
	self evaluateListenersFor: anIPMessage
]

{ #category : #'message-handlers' }
IPWidgetMsgHandler >> commMessageHandler: anIPMessage [
	<ipharo: #comm_msg>
	| comm data |

	comm :=(anIPMessage session commManager commChannelAt:(anIPMessage content at:#comm_id)). 
	"(anIPMessage content at:#target_name ifAbsent:[ nil ]) = self targetName ifFalse:[ ^ nil ] 
	do not check target name...".
	data := anIPMessage content at:#data.
	comm data: data.
 	(data at:#method) = 'update' ifFalse:[ ^ self ].
	comm commListeners do:[ :l | l onDataReceived: data]. 
	self evaluateListenersFor: anIPMessage 

]

{ #category : #'message-handlers' }
IPWidgetMsgHandler >> commOpenHandler: anIPMessage [
	<ipharo: #comm_open>
	anIPMessage content at:#data ifAbsent:[ ^ nil ].
	"(anIPMessage content at:#target_name ifAbsent:[ nil ]) = self targetName ifFalse:[ ^ nil ]."
	self register 
				at: (anIPMessage content at:#comm_id)
				put:
					(IPWidget
					  onSession: anIPMessage session
					  model: anIPMessage content data
					  commId: (anIPMessage content at:#comm_id)).
	self evaluateListenersFor: anIPMessage
]

{ #category : #accessing }
IPWidgetMsgHandler >> register [ 
	^ register ifNil:[ register := Dictionary new ]
]

{ #category : #accessing }
IPWidgetMsgHandler >> targetName [ 	
	^ 'jupyter.widget'
]

{ #category : #'message-handlers' }
IPWidgetMsgHandler >> updateDisplayDataHandler: anIPMessage [
	<ipharo: #update_display_data>
	"this should update the view when the code executed by the server asks for "
	self evaluateListenersFor: anIPMessage

	

]
