accessing
colorPicker
	|i|
	i := IPWidget new model: IPColorPickerModel newInstance.
	^ self openCommFor:i.