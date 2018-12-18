public-api
widgetsFactory
	^ widgetsFactory ifNil:[widgetsFactory := IPWidgetFactory new]