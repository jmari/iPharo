accessing
sliderStyle
	|i|
	i := IPWidget new model: IPSliderStyleModel newInstance.
	^ self openCommFor:i.