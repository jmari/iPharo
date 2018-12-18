accessing
selectionSlider
	|i|
	i := IPWidget new model: IPSelectionSliderModel newInstance.
	^ self openCommFor:i.