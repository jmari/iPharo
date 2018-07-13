initialization
initialize
	super initialize.
	self targetClasses at: 'jupyter.widget.version' put: IPWidgetVersion.
	self targetClasses at: 'jupyter.widget' put: IPWidget