Class {
	#name : #IPWidgetFactory,
	#superclass : #Object,
	#category : 'JupyterTalk-Widgets'
}

{ #category : #'as yet unclassified' }
IPWidgetFactory >> accordion [
	|i|
	i := IPWidget new model: IPAccordionModel newInstance.
	^ self openCommFor:i.


]

{ #category : #'as yet unclassified' }
IPWidgetFactory >> boundedFloatText [
	|i|
	i := IPWidget new model: IPBoundedFloatTextModel newInstance.
	^ self openCommFor:i.
]

{ #category : #'as yet unclassified' }
IPWidgetFactory >> boundedIntText [
	|i|
	i := IPWidget new model: IPBoundedIntTextModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> box [
	|i|
	i := IPWidget new model: IPBoxModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> button [
	|i|
	i := IPWidget new model: IPButtonModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> buttonStyle [
	|i|
	i := IPWidget new model: IPButtonStyleModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> checkbox [
	|i|
	i := IPWidget new model: IPCheckboxModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> colorPicker [
	|i|
	i := IPWidget new model: IPColorPickerModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> controller [
	|i|
	i := IPWidget new model: IPControllerModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> controllerAxis [
	|i|
	i := IPWidget new model: IPControllerAxisModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> controllerButton [
	|i|
	i := IPWidget new model: IPControllerButtonModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> datePicker [
	|i|
	i := IPWidget new model: IPDatePickerModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> descriptionStyle [
	|i|
	i := IPWidget new model: IPDescriptionStyleModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> directionalLink [
	|i|
	i := IPWidget new model: IPDirectionalLinkModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> dropdown [
	|i|

	i := IPWidget new model: IPDropdownModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> floatLogSlider [
	|i|

	i := IPWidget new model: IPFloatLogSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> floatProgress [
	|i|

	i := IPWidget new model: IPFloatProgressModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> floatRangeSlider [
	|i|
	i := IPWidget new model: IPFloatRangeSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> floatSlider [
	|i|

	i := IPWidget new model: IPFloatSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> floatText [
	|i|

	i := IPWidget new model: IPFloatTextModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> gridBox [
	|i|
	i := IPWidget new model: IPGridBoxModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> hBox [
	|i|
	i := IPWidget new model: IPHBoxModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> html [
	|i|
	i := IPWidget new model: IPHTMLModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> htmlMath [
	|i|
	i := IPWidget new model: IPHTMLMathModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> image [
	|i|
	i := IPWidget new model: IPImageModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> intProgress [
	|i|

	i := IPWidget new model: IPIntProgressModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> intRangeSlider [
	|i|
	
	i := IPWidget new model: IPIntRangeSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> intSlider [
	|i|

	i := IPWidget new model: IPIntSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> intText [
	|i|
	i := IPWidget new model: IPIntTextModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> label [
	|i|
	i := IPWidget new model: IPLabelModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> layout [
	|i|
	i := IPWidget new model: IPLayoutModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> link [
	|i|
	i := IPWidget new model: IPLinkModel newInstance.
	^ self openCommFor:i.
]

{ #category : #private }
IPWidgetFactory >> openCommFor: aWidget [
	aWidget comm targetName: aWidget widgetClass.
	aWidget comm open:aWidget model.
	^ aWidget


]

{ #category : #accessing }
IPWidgetFactory >> output [
	|i|
	i := IPWidget new model: IPOutputModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> password [
	|i|
	i := IPWidget new model: IPPasswordModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> play [
	|i|
	i := IPWidget new model: IPPlayModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> progressStyle [
	|i|
	i := IPWidget new model: IPProgressStyleModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> radioButtons [
	|i|
	i := IPWidget new model: IPRadioButtonsModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> select [
	|i|
	i := IPWidget new model: IPSelectModel  newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> selectMultiple [
	|i|
	i := IPWidget new model: IPSelectMultipleModel  newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> selectionRangeSlider [
	|i|
	i := IPWidget new model: IPSelectionRangeSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> selectionSlider [
	|i|
	i := IPWidget new model: IPSelectionSliderModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> sliderStyle [
	|i|
	i := IPWidget new model: IPSliderStyleModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> tab [
	|i|
	i := IPWidget new model: IPTabModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> text [
	|i|
	i := IPWidget new model: IPTextModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> textarea [
	|i|
	i := IPWidget new model: IPTextareaModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> toggleButton [
	|i|
	i := IPWidget new model: IPToggleButtonModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> toggleButtons [
	|i|
	i := IPWidget new model: IPToggleButtonsModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> toggleButtonsStyle [
	|i|
	i := IPWidget new model: IPToggleButtonsStyleModel  newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> vBox [
	|i|
	i := IPWidget new model: IPVBoxModel newInstance.
	^ self openCommFor:i.
]

{ #category : #accessing }
IPWidgetFactory >> valid [
	|i|
	i := IPWidget new model: IPValidModel newInstance.
	^ self openCommFor: i
]

{ #category : #'as yet unclassified' }
IPWidgetFactory >> video [
	|i|
	i := IPWidget new model: IPVideoModel  newInstance.
	^ self openCommFor:i.


]
