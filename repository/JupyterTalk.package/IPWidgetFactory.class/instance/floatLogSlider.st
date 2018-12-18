accessing
floatLogSlider
	|i|

	i := IPWidget new model: IPFloatLogSliderModel newInstance.
	^ self openCommFor:i.