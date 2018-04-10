public-api
display: data from: anInt to: otherInt
	|start end|
	start :=anInt ifNil:[1].
	end := otherInt ifNil:[self defaultNumberOfRows].
	end - start > self maxNumberOfRows ifTrue:[end := start + self maxNumberOfRows ]. 
	^ self display:data extent:anInt@otherInt.	
	 
	
														
														