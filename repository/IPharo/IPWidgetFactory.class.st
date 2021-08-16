"
I'm the widget factory. All of the Widget instances should be created by me. Each IPSession has one widgetFactory, can access sending self widgetFactory from the execution context.

 
Internal Representation and Key Implementation Points.

    Instance Variables
	session:		<IPSession>


    Implementation Points
on each method we create and return an instance of a widget assinging its object model and session.
More details at:
https://ipywidgets.readthedocs.io/en/latest/examples/Widget%20Low%20Level.html#Models-and-Views
"
Class {
	#name : #IPWidgetFactory,
	#superclass : #Object,
	#instVars : [
		'session'
	],
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPWidgetFactory class >> new [
	self error: 'You should use onSesson: for instance creation'
	
]

{ #category : #'instance creation' }
IPWidgetFactory class >> onSession: anIPSession [
	| i |
	i := self basicNew.
	i initialize.
	i session:anIPSession.
	^ i
	
]

{ #category : #accessing }
IPWidgetFactory >> accordion [

	^ IPWidget
		  onSession: self session
		  model: IPAccordionModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> boundedFloatText [

	^ IPWidget
		  onSession: self session
		  model: IPBoundedFloatTextModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> boundedIntText [

	^ IPWidget
		  onSession: self session
		  model: IPBoundedIntTextModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> box [

	^ IPWidget onSession: self session model: IPBoxModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> button [

	^ IPWidget onSession: self session model: IPButtonModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> buttonStyle [

	^ IPWidget
		  onSession: self session
		  model: IPButtonStyleModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> checkbox [

	^ IPWidget onSession: self session model: IPCheckboxModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> colorPicker [

	^ IPWidget
		  onSession: self session
		  model: IPColorPickerModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> controller [

	^ IPWidget
		  onSession: self session
		  model: IPControllerModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> controllerAxis [

	^ IPWidget
		  onSession: self session
		  model: IPControllerAxisModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> controllerButton [

	^ IPWidget
		  onSession: self session
		  model: IPControllerButtonModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> datePicker [

	^ IPWidget
		  onSession: self session
		  model: IPDatePickerModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> descriptionStyle [

	^ IPWidget
		  onSession: self session
		  model: IPDescriptionStyleModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> directionalLink [

	^ IPWidget
		  onSession: self session
		  model: IPDirectionalLinkModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> dropdown [

	^ IPWidget onSession: self session model: IPDropdownModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> floatLogSlider [

	^ IPWidget
		  onSession: self session
		  model: IPFloatLogSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> floatProgress [

	^ IPWidget
		  onSession: self session
		  model: IPFloatProgressModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> floatRangeSlider [

	^ IPWidget
		  onSession: self session
		  model: IPFloatRangeSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> floatSlider [

	^ IPWidget
		  onSession: self session
		  model: IPFloatSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> floatText [

	^ IPWidget
		  onSession: self session
		  model: IPFloatTextModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> gridBox [

	^ IPWidget onSession: self session model: IPGridBoxModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> hBox [

	^ IPWidget onSession: self session model: IPHBoxModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> html [

	^ IPWidget onSession: self session model: IPHTMLModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> htmlMath [

	^ IPWidget onSession: self session model: IPHTMLMathModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> image [

	^ IPWidget onSession: self session model: IPImageModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> intProgress [

	^ IPWidget
		  onSession: self session
		  model: IPIntProgressModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> intRangeSlider [

	^ IPWidget
		  onSession: self session
		  model: IPIntRangeSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> intSlider [

	^ IPWidget
		  onSession: self session
		  model: IPIntSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> intText [

	^ IPWidget onSession: self session model: IPIntTextModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> label [

	^ IPWidget onSession: self session model: IPLabelModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> layout [

	^ IPWidget onSession: self session model: IPLayoutModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> link [

	^ IPWidget onSession: self session model: IPLinkModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> output [

	^ IPWidget onSession: self session model: IPOutputModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> password [

	^ IPWidget onSession: self session model: IPPasswordModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> play [

	^ IPWidget onSession: self session model: IPPlayModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> progressStyle [

	^ IPWidget
		  onSession: self session
		  model: IPProgressStyleModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> radioButtons [

	^ IPWidget
		  onSession: self session
		  model: IPRadioButtonsModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> select [

	^ IPWidget onSession: self session model: IPSelectModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> selectMultiple [

	^ IPWidget
		  onSession: self session
		  model: IPSelectMultipleModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> selectionRangeSlider [

	^ IPWidget
		  onSession: self session
		  model: IPSelectionRangeSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> selectionSlider [

	^ IPWidget
		  onSession: self session
		  model: IPSelectionSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> session [

	^ session
]

{ #category : #accessing }
IPWidgetFactory >> session: anObject [

	session := anObject
]

{ #category : #accessing }
IPWidgetFactory >> sliderStyle [

	^ IPWidget
		  onSession: self session
		  model: IPSliderStyleModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> tab [

	^ IPWidget onSession: self session model: IPTabModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> text [

	^ IPWidget onSession: self session model: IPTextModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> textarea [

	^ IPWidget onSession: self session model: IPTextareaModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> toggleButton [

	^ IPWidget
		  onSession: self session
		  model: IPToggleButtonModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> toggleButtons [

	^ IPWidget
		  onSession: self session
		  model: IPToggleButtonsModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> toggleButtonsStyle [

	^ IPWidget
		  onSession: self session
		  model: IPToggleButtonsStyleModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> vBox [

	^ IPWidget onSession: self session model: IPVBoxModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> valid [

	^ IPWidget onSession: self session model: IPValidModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> video [

	^ IPWidget onSession: self session model: IPVideoModel newInstance
]
