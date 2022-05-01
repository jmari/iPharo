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

{ #category : #factory }
IPWidgetFactory >> accordion [
	^ self createWidgetWithModel: IPAccordionModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> boundedFloatText [
	^ self createWidgetWithModel: IPBoundedFloatTextModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> boundedIntText [

	^ self createWidgetWithModel:  IPBoundedIntTextModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> box [

	^ self createWidgetWithModel:  IPBoxModel newInstance.
	
	
	
]

{ #category : #factory }
IPWidgetFactory >> button [

	^ self createWidgetWithModel:  IPButtonModel newInstance.
	
	
]

{ #category : #factory }
IPWidgetFactory >> buttonStyle [

	^ self createWidgetWithModel:  IPButtonStyleModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> checkbox [

	^ self createWidgetWithModel:  IPCheckboxModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> colorPicker [

	^ self createWidgetWithModel: IPColorPickerModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> controller [

	^ self createWidgetWithModel:  IPControllerModel newInstance.

	
]

{ #category : #factory }
IPWidgetFactory >> controllerAxis [

	^ self createWidgetWithModel:   IPControllerAxisModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> controllerButton [

	^ self createWidgetWithModel:   IPControllerButtonModel newInstance.

]

{ #category : #creation }
IPWidgetFactory >> createWidgetWithModel: modelInstance [
	^ IPWidget
		  onSession: self session
		  model: modelInstance


]

{ #category : #factory }
IPWidgetFactory >> datePicker [

	^ self createWidgetWithModel:   IPDatePickerModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> descriptionStyle [

	^ self createWidgetWithModel: IPDescriptionStyleModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> directionalLink [
	
	^ self createWidgetWithModel:  IPDirectionalLinkModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> dropdown [

	^ self createWidgetWithModel:  IPDropdownModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> floatLogSlider [

	^ self createWidgetWithModel: IPFloatLogSliderModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> floatProgress [

	^ self createWidgetWithModel:  IPFloatProgressModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> floatRangeSlider [

	^ self createWidgetWithModel:  IPFloatRangeSliderModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> floatSlider [

	^ self createWidgetWithModel:  IPFloatSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> floatText [

	^ self createWidgetWithModel:  IPFloatTextModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> gridBox [

	^ self createWidgetWithModel:  IPGridBoxModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> hBox [

	^ self createWidgetWithModel:  IPHBoxModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> html [

	^ self createWidgetWithModel:  IPHTMLModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> htmlMath [

	^ self createWidgetWithModel: IPHTMLMathModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> image [
	
	^ self createWidgetWithModel:  IPImageModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intProgress [
	
	^ self createWidgetWithModel:  IPIntProgressModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intRangeSlider [

	^ self createWidgetWithModel:  IPIntRangeSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intSlider [
	
	^ self createWidgetWithModel:  IPIntSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intText [

	^ self createWidgetWithModel:  IPIntTextModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> label [

	^ self createWidgetWithModel:  IPLabelModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> layout [

	^ self createWidgetWithModel:  IPLayoutModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> link [

	^ self createWidgetWithModel:  IPLinkModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> output [

	^ self createWidgetWithModel:  IPOutputModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> password [

	^ self createWidgetWithModel:  IPPasswordModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> play [
	
	^ self createWidgetWithModel:  IPPlayModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> progressStyle [

	^ self createWidgetWithModel:  IPProgressStyleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> radioButtons [

	^ self createWidgetWithModel: IPRadioButtonsModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> select [

	^ self createWidgetWithModel: IPSelectModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> selectMultiple [

	^ self createWidgetWithModel:  IPSelectMultipleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> selectionRangeSlider [
	
	^ self createWidgetWithModel:  IPSelectionRangeSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> selectionSlider [

	^ self createWidgetWithModel:  IPSelectionSliderModel newInstance
]

{ #category : #accessing }
IPWidgetFactory >> session [
	"session is used by comm"
	^ session
]

{ #category : #accessing }
IPWidgetFactory >> session: anObject [

	session := anObject
]

{ #category : #factory }
IPWidgetFactory >> sliderStyle [

	^ self createWidgetWithModel: IPSliderStyleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> tab [
	
	^ self createWidgetWithModel: IPTabModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> text [

	^ self createWidgetWithModel: IPTextModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> textarea [

	^ self createWidgetWithModel: IPTextareaModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> toggleButton [

	^ self createWidgetWithModel: IPToggleButtonModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> toggleButtons [
	
	^ self createWidgetWithModel:  IPToggleButtonsModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> toggleButtonsStyle [

	^ self createWidgetWithModel: IPToggleButtonsStyleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> vBox [

	^ self createWidgetWithModel: IPVBoxModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> valid [

	^ self createWidgetWithModel: IPValidModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> video [

	^ self createWidgetWithModel: IPVideoModel newInstance
]
