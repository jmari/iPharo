accessing
selectionRangeSlider
	|i|
	i := IPWidget new model: IPSelectionRangeSliderModel newInstance.
	^ self openCommFor:i.