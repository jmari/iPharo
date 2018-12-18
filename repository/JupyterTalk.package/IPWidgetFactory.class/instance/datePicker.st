accessing
datePicker
	|i|
	i := IPWidget new model: IPDatePickerModel newInstance.
	^ self openCommFor:i.