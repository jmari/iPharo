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
	<jupyterWidget: #Accordion>
	^ self createWidgetWithModel: IPAccordionModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> boundedFloatText [
	<jupyterWidget: #BoundedFloatText>
	
	^ self createWidgetWithModel: IPBoundedFloatTextModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> boundedIntText [
<jupyterWidget: #BoundedIntText>
	^ self createWidgetWithModel:  IPBoundedIntTextModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> box [
	<jupyterWidget: #Box>
	^ self createWidgetWithModel:  IPBoxModel newInstance.
	
	
	
]

{ #category : #factory }
IPWidgetFactory >> button [
	<jupyterWidget: #Button>
	^ self createWidgetWithModel:  IPButtonModel newInstance.
	
	
]

{ #category : #factory }
IPWidgetFactory >> buttonStyle [
	<jupyterWidget: #ButtonStyle>
	^ self createWidgetWithModel:  IPButtonStyleModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> checkbox [
	<jupyterWidget: #Checkbox>
	^ self createWidgetWithModel:  IPCheckboxModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> colorPicker [
	<jupyterWidget: #ColorPicker>
	^ self createWidgetWithModel: IPColorPickerModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> controller [
	<jupyterWidget: #Controller>
	^ self createWidgetWithModel:  IPControllerModel newInstance.

	
]

{ #category : #factory }
IPWidgetFactory >> controllerAxis [
	<jupyterWidget: #ControllerAxis>
	^ self createWidgetWithModel:   IPControllerAxisModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> controllerButton [
	<jupyterWidget: #ControllerButton>
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
	<jupyterWidget: #DatePicker>
	^ self createWidgetWithModel:   IPDatePickerModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> descriptionStyle [
	<jupyterWidget: #DescriptionStyle>
	^ self createWidgetWithModel: IPDescriptionStyleModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> directionalLink [
	<jupyterWidget: #DirectionalLink>
	^ self createWidgetWithModel:  IPDirectionalLinkModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> dropdown [
	<jupyterWidget: #dropdown>
	^ self createWidgetWithModel:  IPDropdownModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> floatLogSlider [
	<jupyterWidget: #FloatLogSlider>
	^ self createWidgetWithModel: IPFloatLogSliderModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> floatProgress [
	<jupyterWidget: #FloatProgress>
	^ self createWidgetWithModel:  IPFloatProgressModel newInstance.

]

{ #category : #factory }
IPWidgetFactory >> floatRangeSlider [
	<jupyterWidget: #FloatRangeSlider>
	^ self createWidgetWithModel:  IPFloatRangeSliderModel newInstance.
	
]

{ #category : #factory }
IPWidgetFactory >> floatSlider [
	<jupyterWidget: #FloatSlider>
	^ self createWidgetWithModel:  IPFloatSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> floatText [
	<jupyterWidget: #FloatText>
	^ self createWidgetWithModel:  IPFloatTextModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> gridBox [
	<jupyterWidget: #GridBox>
	^ self createWidgetWithModel:  IPGridBoxModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> hBox [
	<jupyterWidget: #HBox>
	^ self createWidgetWithModel:  IPHBoxModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> html [
	<jupyterWidget: #Html>
	^ self createWidgetWithModel:  IPHTMLModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> htmlMath [
	<jupyterWidget: #HtmlMath>
	^ self createWidgetWithModel: IPHTMLMathModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> image [
	<jupyterWidget: #Image>
	^ self createWidgetWithModel:  IPImageModel newInstance
]

{ #category : #initialization }
IPWidgetFactory >> initialize [ 
	super initialize.
	"kernel should be able to create widget classes"
	IPharoKernel instance publisher 
									addHandlersFromPragma: #jupyterWidget: 
									inClass: self class 
									handlerInstance: self 
]

{ #category : #factory }
IPWidgetFactory >> intProgress [
	<jupyterWidget: #IntProgress>
	^ self createWidgetWithModel:  IPIntProgressModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intRangeSlider [
	<jupyterWidget: #IntRangeSlider>
	^ self createWidgetWithModel:  IPIntRangeSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intSlider [
	<jupyterWidget: #IntSlider>
	^ self createWidgetWithModel:  IPIntSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> intText [
	<jupyterWidget: #IntText>
	^ self createWidgetWithModel:  IPIntTextModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> label [
	<jupyterWidget: #Label>
	^ self createWidgetWithModel:  IPLabelModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> layout [
	<jupyterWidget: #Layout>
	^ self createWidgetWithModel:  IPLayoutModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> link [
	<jupyterWidget: #Link>
	^ self createWidgetWithModel:  IPLinkModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> output [
	<jupyterWidget: #Output>
	^ self createWidgetWithModel:  IPOutputModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> password [
	<jupyterWidget: #Password>
	^ self createWidgetWithModel:  IPPasswordModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> play [
	<jupyterWidget: #Play>
	^ self createWidgetWithModel:  IPPlayModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> progressStyle [
	<jupyterWidget: #ProgressStyle>
	^ self createWidgetWithModel:  IPProgressStyleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> radioButtons [
	<jupyterWidget: #RadioButtons>
	^ self createWidgetWithModel: IPRadioButtonsModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> select [
	<jupyterWidget: #Select>
	^ self createWidgetWithModel: IPSelectModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> selectMultiple [
	<jupyterWidget: #SelectMultiple>
	^ self createWidgetWithModel:  IPSelectMultipleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> selectionRangeSlider [
	<jupyterWidget: #SelectionRangeSlider>
	^ self createWidgetWithModel:  IPSelectionRangeSliderModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> selectionSlider [
	<jupyterWidget: #SelectionSlider>
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
	<jupyterWidget: #SliderStyle>
	^ self createWidgetWithModel: IPSliderStyleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> tab [
	<jupyterWidget: #Tab>
	^ self createWidgetWithModel: IPTabModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> text [
	<jupyterWidget: #Text>
	^ self createWidgetWithModel: IPTextModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> textarea [
	<jupyterWidget: #Textarea>
	^ self createWidgetWithModel: IPTextareaModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> toggleButton [
	<jupyterWidget: #ToggleButton>
	^ self createWidgetWithModel: IPToggleButtonModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> toggleButtons [
	<jupyterWidget: #ToggleButtons>
	^ self createWidgetWithModel:  IPToggleButtonsModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> toggleButtonsStyle [
	<jupyterWidget: #ToggleButtonsStyle>
	^ self createWidgetWithModel: IPToggleButtonsStyleModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> vBox [
	<jupyterWidget: #VBox>
	^ self createWidgetWithModel: IPVBoxModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> valid [
	<jupyterWidget: #Valid>
	^ self createWidgetWithModel: IPValidModel newInstance
]

{ #category : #factory }
IPWidgetFactory >> video [
	<jupyterWidget: #Video>
	^ self createWidgetWithModel: IPVideoModel newInstance
]
