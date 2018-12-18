accessing
intSlider
	|i|

	i := IPWidget new model: IPIntSliderModel newInstance.
	^ self openCommFor:i.