accessing
data

	^  self content at:#data ifAbsentPut:[
		{	#method->#update.
			#state->nil.
			#buffer_paths:nil} asSCJsonObject ].
