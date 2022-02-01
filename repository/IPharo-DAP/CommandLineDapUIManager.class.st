Class {
	#name : #CommandLineDapUIManager,
	#superclass : #NonInteractiveUIManager,
	#category : #'IPharo-DAP'
}

{ #category : #debug }
CommandLineDapUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [
	
	(OupsDebugRequest newForContext: context)
		process: process;
		label: title;
		submit
]

{ #category : #'handle debug requests' }
CommandLineDapUIManager >> handleDebugRequest: aDebugRequest [
	| debuggerOpeningStrategy oupsSystem |
  
	oupsSystem := OupsDebuggerSystem new.
	aDebugRequest debugSession logStackToFileIfNeeded.
	oupsSystem performPreDebugActionsIn: aDebugRequest.
	oupsSystem ensureExceptionIn: aDebugRequest debugSession.
	debuggerOpeningStrategy := oupsSystem debuggerSelectionStrategy.
	debuggerOpeningStrategy openDebuggerForSession:aDebugRequest debugSession.
	oupsSystem suspendDebuggedProcess: aDebugRequest
]

{ #category : #debug }
CommandLineDapUIManager >> handleError: anError log: shouldLog [

	self handleDebugRequest: (OupsDebugRequest newForException: anError)

]

{ #category : #'handle debug requests' }
CommandLineDapUIManager >> handleWarningDebugRequest: aWarningDebugRequest [

	self handleDebugRequest:  aWarningDebugRequest	
]

{ #category : #'ui requests' }
CommandLineDapUIManager >> inform: aString [
	| ws |
	ws := (FileLocator home / 'dap_inform') ensureCreateFile writeStream.
	ws nextPutAll: aString.
	ws flush;close.

]

{ #category : #'default actions' }
CommandLineDapUIManager >> unhandledErrorDefaultAction: anException [

	anException debug

	
]
