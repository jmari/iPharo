accessing
floatSlider
	|i|

	i := IPWidget new model: IPFloatSliderModel newInstance.
	^ self openCommFor:i.