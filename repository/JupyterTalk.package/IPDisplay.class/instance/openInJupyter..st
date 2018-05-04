public-api
openInJupyter: data 
	|aJupyterData  uuid  |
	
	
	aJupyterData := (interaction and:[data respondsTo:#asJupyterInteractiveDataWithExtent:]) 
							ifTrue:[data asJupyterInteractiveDataWithExtent: self extent]
							ifFalse:[data asJupyterDataWithExtent: self extent].	
	self jupyterData data at:aJupyterData key put:aJupyterData value.
	self jupyterData metadata:{
 									aJupyterData key -> {
    															'width' -> self extent x.
    															'height' -> self extent y
 														 	} asSCJsonObject.
														} asSCJsonObject.
	uuid:= UUID new hex asString asUppercase.
	self jupyterData transient: {#display_id -> uuid} asSCJsonObject.
	self class cachedObjects 
						at:uuid put: {    #data-> data.
												#interactive-> interaction.
												#extent->self extent.
												#metadata ->self jupyterData metadata} asDictionary. 
	^ uuid