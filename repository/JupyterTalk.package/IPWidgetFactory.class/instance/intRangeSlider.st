accessing
intRangeSlider
	|i|
	
	i := IPWidget new model: IPIntRangeSliderModel newInstance.
	^ self openCommFor:i.