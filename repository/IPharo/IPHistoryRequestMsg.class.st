Class {
	#name : #IPHistoryRequestMsg,
	#superclass : #IPMsg,
	#category : #'IPharo-Messages-Shell'
}

{ #category : #initialization }
IPHistoryRequestMsg >> initialize [
	super initialize.
	self msgType: #history_request.
	self parentHeader: '{}' asByteArray .
	self metadata: SCJsonObject new.
	content = {
  		"If True, also return output history in the resulting dict."
  		'output' -> true.
 		"If True, return the raw input history, else the transformed input."
  		'raw' -> true.
  		"So far, this can be 'range', 'tail' or 'search'."
  		'hist_access_type'-> 'tail'.
  		"If hist_access_type is 'range', get a range of input cells. session
  		is a number counting up each time the kernel starts; you can give
  		a positive session number, or a negative number to count back from
  		the current session."
  		'session'-> 1.
  		"start and stop are line (cell) numbers within that session."
  		'start'-> 1.
  		'stop' -> 1.
  		"If hist_access_type is 'tail' or 'search', get the last n cells."
  		'n' -> 5.
  		"If hist_access_type is 'search', get cells matching the specified glob
  		pattern (with * and ? as wildcards)."
  		'pattern'-> '*'.
  		"If hist_access_type is 'search' and unique is true, do not
  		include duplicated history.  Default is false."
  		'unique' -> false } asSCJsonObject 
]
