accessing
floatRangeSlider
	|i|
	i := IPWidget new model: IPFloatRangeSliderModel newInstance.
	^ self openCommFor:i.