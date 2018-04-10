*JupyterTalk-Core
asJupyterDataSize:aPoint
	|htmlStream start end|
	end := aPoint y > self size ifTrue:[self size] ifFalse:[aPoint y].
	start := aPoint x > end ifTrue:[end] ifFalse:[aPoint x].
	htmlStream := ReadWriteStream on:String new.
	htmlStream 
			nextPutAll:'<table>';cr;
			nextPutAll:'<tr>'.
	(self first isKindOf: SequenceableCollection)
		ifTrue:[ self first do:[:each| 
						htmlStream nextPutAll:'<th>';	nextPutAll:each asString;nextPutAll:'</th>']]
		ifFalse:[htmlStream nextPutAll:'<th>';	nextPutAll:self first asString;nextPutAll:'</th>'].	
			
	(self allButFirst copyFrom:start  to:(end - 1)) do:[ :eachRow|
		htmlStream nextPutAll:'<tr>'.
		(eachRow isKindOf: SequenceableCollection) ifTrue:[
			eachRow do:[:eachElement| htmlStream nextPutAll:'<td>';	nextPutAll:eachElement asString;nextPutAll:'</td>']].	
		htmlStream nextPutAll:'</tr>'].
	htmlStream nextPutAll:'</table>'.
	
	^ 'text/html' -> htmlStream contents 