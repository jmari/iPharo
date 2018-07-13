accessing
model
	^ model ifNil:[
		model := IPWidgetModel new.
		model onChange:[:kv| self update:kv].
		model]