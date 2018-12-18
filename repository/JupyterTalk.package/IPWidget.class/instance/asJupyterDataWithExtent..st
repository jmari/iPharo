converting
asJupyterDataWithExtent: size

	^ 'application/vnd.jupyter.widget-view+json'->{
			'model_id'->self comm uuid.
			'version_major'->(self model at:'version_major').
			'version_minor'->(self model at:'version_minor'). 
			} asSCJsonObject 
	