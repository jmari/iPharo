*JupyterTalk-Core
asJupyterDataWithExtent:aPoint
	|htmlStream  |

	htmlStream := ReadWriteStream on:String new.
	htmlStream 
			nextPutAll:'<table>';cr;
			nextPutAll:'<tr>'.
	(self first isKindOf: SequenceableCollection)
		ifTrue:[ self first do:[:each| 
						htmlStream nextPutAll:'<th>';	nextPutAll:each asString;nextPutAll:'</th>']]
		ifFalse:[htmlStream nextPutAll:'<th>';	nextPutAll:self first asString;nextPutAll:'</th>'].	
			
	self allButFirst do:[ :eachRow|
		htmlStream nextPutAll:'<tr>'.
		(eachRow isKindOf: SequenceableCollection) 
		ifTrue:[
			eachRow do:[:eachElement| htmlStream nextPutAll:'<td>';	nextPutAll:eachElement asString;nextPutAll:'</td>']]
		ifFalse:[htmlStream nextPutAll:'<td>';	nextPutAll: eachRow  asString;nextPutAll:'</td>'].
		htmlStream nextPutAll:'</tr>'].
	htmlStream nextPutAll:'</table>'.
	
	^ 'text/html' -> htmlStream contents 