Extension { #name : #RTTabTable }

{ #category : #'*JupyterTalk-Roassal' }
RTTabTable >> asJupyterDataWithExtent: aPoint [
	|htmlStream start end|
	
	end := aPoint y > self value size ifTrue:[self value size] ifFalse:[aPoint y].
	start := aPoint x > end ifTrue:[end] ifFalse:[aPoint x].
	htmlStream := ReadWriteStream on:String new.
	htmlStream 
			nextPutAll:'<table class=', self jupyterHtmlClass ,'>';cr;
			nextPutAll:'<tr>'.
	self firstRow do:[:each| 
		htmlStream nextPutAll:'<th>';	nextPutAll:each asString;nextPutAll:'</th>'].		 
	htmlStream 	nextPutAll:'</tr>'.
	(self values copyFrom:start to:(end - 1)) do:[ :eachRow|
		htmlStream nextPutAll:'<tr>'.
		eachRow do:[:eachElement| htmlStream nextPutAll:'<td>';	nextPutAll:eachElement asString;nextPutAll:'</td>'].	
		htmlStream nextPutAll:'</tr>'].
	htmlStream nextPutAll:'</table>'.
	
	^ 'text/html' -> htmlStream contents 
	
		
]

{ #category : #'*JupyterTalk-Roassal' }
RTTabTable >> jupyterHtmlClass [
	^ '"document"'
]
