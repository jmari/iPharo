Extension { #name : #SequenceableCollection }

{ #category : #'*IPharo-Core' }
SequenceableCollection >> asJupyterDataWithExtent:aPoint [
		|htmlStream  |
	self isEmpty ifTrue:[^ nil].
	(self isCollection & self isString not)
	ifFalse:[ ^ self asString asJupyterDataWithExtent:aPoint].
	
	htmlStream := ReadWriteStream on:String new.
	htmlStream 
			nextPutAll:'<table>';cr;
			nextPutAll:'<tr>'.
	(self isCollection & self isString not)
		ifTrue:[ self first do:[:each| 
						htmlStream nextPutAll:'<th>';	nextPutAll:each asString;nextPutAll:'</th>']]
		ifFalse:[htmlStream nextPutAll:'<th>';	nextPutAll:self first asString;nextPutAll:'</th>'].	
			
	self allButFirst do:[ :eachRow|
		htmlStream nextPutAll:'<tr>'.
		(self isCollection & self isString not) 
		ifTrue:[
			eachRow do:[:eachElement| htmlStream nextPutAll:'<td>';	nextPutAll:eachElement asString;nextPutAll:'</td>']]
		ifFalse:[htmlStream nextPutAll:'<td>';	nextPutAll: eachRow  asString;nextPutAll:'</td>'].
		htmlStream nextPutAll:'</tr>'].
	htmlStream nextPutAll:'</table>'.
	
	^ 'text/html' -> htmlStream contents 
]
