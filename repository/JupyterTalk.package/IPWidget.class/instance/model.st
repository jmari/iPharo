accessing
model
	^ model ifNil:[	model := IPCoreWidgetModelGenerator new]