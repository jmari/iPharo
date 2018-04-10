public-api
display: data extent: aPoint
	|aJupyterData size uuid  |
	
	size:= aPoint ifNil:[ 640@640].
	aJupyterData := data asJupyterDataSize:size.	
	self jupyterData data at:aJupyterData key put:aJupyterData value.
	aPoint 
		ifNil:[self jupyterData metadata:SCJsonObject new]
		ifNotNil:[ self jupyterData metadata:{
  															aJupyterData key -> {
    																	'width' ->aPoint x.
    																	'height' -> aPoint y
 															 	} asSCJsonObject.
															} asSCJsonObject].
	uuid:= UUID new hex asString asUppercase.
	self jupyterData at: #transient put: {#display_id -> uuid} asSCJsonObject.
	self cachedObjects at:uuid put: { #data-> data.
												#interactive-> false.
												#extent->aPoint.
												#metadata ->self jupyterData metadata} asDictionary. 
	^ uuid
	 
	
														
														