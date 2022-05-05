"
I'm a jupyter widget. I'm responsible to store the widget model and manage it using my state-accessors. 
I also keep an instance of a IPComm and use it for publish the changes in my state model. 

All of my instances should be created by sending messages to the IPWidgetFactory. Each IPSession has one widgetFactory.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	comm:		<IPComm>
	listeners:		<OrderedCollection> store one argument (event) BlockClosures.
	model:		<IPCoreWidgetModelGenerator subclass>

   
"
Class {
	#name : #IPWidget,
	#superclass : #IPCommListener,
	#instVars : [
		'model',
		'comm',
		'listeners'
	],
	#category : #'IPharo-Widgets'
}

{ #category : #'instance creation' }
IPWidget class >> new [
	self error: 'You should use model: onSession: for instance creation'
]

{ #category : #'instance creation' }
IPWidget class >> onSession: anIPSession model: aModel [
	| i |
	i := self basicNew.
	i initialize.
	i comm: (IPComm onSession:anIPSession).
	i comm addCommListener: i.
	i model: aModel.
	i openComm.
	^ i
]

{ #category : #'instance creation' }
IPWidget class >> onSession: anIPSession model: aModel commId: uuid [
	| i |
	i := self basicNew.
	i initialize.
	i comm: (IPComm new: uuid onSession:anIPSession).
	i comm addCommListener: i.
	i model: aModel.
	i openComm.
	^ i
]

{ #category : #'state-accessors' }
IPWidget >> alignContent [
	^ self getProperty: #align_content
]

{ #category : #'state-accessors' }
IPWidget >> alignContent: anObject [
	 self setProperty: #align_content value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> alignItems [
	^ self getProperty: #align_items
]

{ #category : #'state-accessors' }
IPWidget >> alignItems: anObject [
	 self setProperty: #align_items value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> alignSelf [
	^ self getProperty: #align_self
]

{ #category : #'state-accessors' }
IPWidget >> alignSelf: anObject [
	 self setProperty: #align_self value: anObject
]

{ #category : #converting }
IPWidget >> asJupyterDataWithExtent: size [

	^{ 'application/vnd.jupyter.widget-view+json'->{
			'model_id'->self comm uuid.
			'version_major'->(self model at:'version_major').
			'version_minor'->(self model at:'version_minor'). 
			} asSCJsonObject } asSCJsonObject 
	
]

{ #category : #'state-accessors' }
IPWidget >> autoplay [
	^ self getProperty: #autoplay
]

{ #category : #'state-accessors' }
IPWidget >> autoplay: aBool [
	 self setProperty: #autoplay value: aBool
]

{ #category : #'state-accessors' }
IPWidget >> axes [
	^ self getProperty: #axes
]

{ #category : #'state-accessors' }
IPWidget >> axes: anArray [
	 self setProperty: #axes value: anArray
]

{ #category : #'state-accessors' }
IPWidget >> barColor [
	^ self getProperty: #bar_color
]

{ #category : #'state-accessors' }
IPWidget >> barColor: aString [
	 self setProperty: #bar_color value: aString
]

{ #category : #'state-accessors' }
IPWidget >> barStyle [
	^ self getProperty: #bar_style

]

{ #category : #'state-accessors' }
IPWidget >> barStyle: anObject [
"'success', 'info', 'warning', 'danger', ''"
	self setProperty: #bar_style value: anObject
	
]

{ #category : #'state-accessors' }
IPWidget >> base [
	^ self getProperty: #base
]

{ #category : #'state-accessors' }
IPWidget >> base: anObject [

	self setProperty: #base value: anObject
	
]

{ #category : #'state-accessors' }
IPWidget >> border [
	^ self getProperty: #border
]

{ #category : #'state-accessors' }
IPWidget >> border: anObject [
	 self setProperty: #border value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> bottom [
	^ self getProperty: #bottom
]

{ #category : #'state-accessors' }
IPWidget >> bottom: anObject [
	 self setProperty: #bottom value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> boxStyle [
	^ self getProperty: #box_style

]

{ #category : #'state-accessors' }
IPWidget >> boxStyle: aString [
	self setProperty: #box_style value: aString
	
]

{ #category : #'state-accessors' }
IPWidget >> buttonColor [
	^ self getProperty: #button_color
]

{ #category : #'state-accessors' }
IPWidget >> buttonColor: aString [
	 self setProperty: #button_color value: aString
]

{ #category : #'state-accessors' }
IPWidget >> buttonStyle [
	^ self getProperty: #button_style
]

{ #category : #'state-accessors' }
IPWidget >> buttonStyle: aString [
	 self setProperty: #button_style value: aString
]

{ #category : #'state-accessors' }
IPWidget >> buttonWidth [
	^ self getProperty: #button_width
]

{ #category : #'state-accessors' }
IPWidget >> buttonWidth: aString [
	 self setProperty: #button_width value: aString
]

{ #category : #'state-accessors' }
IPWidget >> buttons [
	^ self getProperty: #buttons
]

{ #category : #'state-accessors' }
IPWidget >> buttons: anArray [
	 self setProperty: #button value: anArray
]

{ #category : #'state-accessors' }
IPWidget >> children [
	^  self getProperty: #children
]

{ #category : #'state-accessors' }
IPWidget >> children: anArray [
	self setProperty: #children value: anArray
]

{ #category : #'comm-actions' }
IPWidget >> close [
	self comm close
]

{ #category : #accessing }
IPWidget >> comm [
	^ comm 

]

{ #category : #accessing }
IPWidget >> comm: aComm [
	comm := aComm

]

{ #category : #'state-accessors' }
IPWidget >> concise [
	^ self getProperty: #concise

]

{ #category : #'state-accessors' }
IPWidget >> concise: aBoolean [

	self setProperty: #concise value: aBoolean
]

{ #category : #'state-accessors' }
IPWidget >> connected [
	^ self getProperty: #connected

]

{ #category : #'state-accessors' }
IPWidget >> connected: aBoolean [

	self setProperty: #connected value: aBoolean
]

{ #category : #'state-accessors' }
IPWidget >> continuousUpdate [
	^ self getProperty: #continuous_update

]

{ #category : #'state-accessors' }
IPWidget >> continuousUpdate: aBoolean [

	self setProperty: #continuous_update value: aBoolean
]

{ #category : #'state-accessors' }
IPWidget >> controls [
	^ self getProperty: #controls
]

{ #category : #'state-accessors' }
IPWidget >> controls: aBool [
	 self setProperty: #controls value: aBool
]

{ #category : #'state-accessors' }
IPWidget >> description [
	^ self getProperty: #description

]

{ #category : #'state-accessors' }
IPWidget >> description: aString [
	"'success', 'info', 'warning', 'danger', ''"
	self setProperty: #description value: aString
]

{ #category : #'state-accessors' }
IPWidget >> description_width [
	^ self getProperty: #description_width

]

{ #category : #'state-accessors' }
IPWidget >> description_width: aString [

	self setProperty: #description_width value: aString
]

{ #category : #'state-accessors' }
IPWidget >> disabled [
	^ self getProperty: #disabled

]

{ #category : #'state-accessors' }
IPWidget >> disabled: aBoolean [
	self setProperty: #disabled value: aBoolean
]

{ #category : #'state-accessors' }
IPWidget >> display [
	^ self getProperty: #display
]

{ #category : #'state-accessors' }
IPWidget >> display: anObject [
	 self setProperty: #display value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> domClasses [
	^ self getProperty: #_dom_classes

	
]

{ #category : #'state-accessors' }
IPWidget >> flex [
	^ self getProperty: #flex
]

{ #category : #'state-accessors' }
IPWidget >> flex: anObject [
	 self setProperty: #flex value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> flexFlow [
	^ self getProperty: #flex_flow
]

{ #category : #'state-accessors' }
IPWidget >> flexFlow: anObject [
	 self setProperty: #flex_flow value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> fontWeight [
	^ self getProperty: #font_weight

]

{ #category : #'state-accessors' }
IPWidget >> fontWeight: aString [
	self setProperty: #font_weight  value: aString 

]

{ #category : #'state-accessors' }
IPWidget >> format [
	^ self getProperty: #format

]

{ #category : #'state-accessors' }
IPWidget >> format: aString [

	self setProperty: #format value: aString
]

{ #category : #accessing }
IPWidget >> getProperty: aProperty [
	^ (self stateIncludesKey:aProperty) 
		ifTrue:[ self model state at:aProperty]
		ifFalse:[MessageNotUnderstood signal: aProperty, ' could not be found']
]

{ #category : #'state-accessors' }
IPWidget >> gridArea [
	^ self getProperty:#grid_area 
				
]

{ #category : #'state-accessors' }
IPWidget >> gridArea: aString [
	self setProperty:#grid_area value:aString 
				
]

{ #category : #'state-accessors' }
IPWidget >> gridAutoColumns [
	^ self getProperty:#grid_auto_columns 
				
]

{ #category : #'state-accessors' }
IPWidget >> gridAutoColumns: aString [
	self setProperty:#grid_auto_columns value: aString
				
]

{ #category : #'state-accessors' }
IPWidget >> gridAutoFlow [
	^ self getProperty:#grid_auto_flow.
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridAutoFlow: aString [
	self setProperty:#grid_auto_flow value: aString
	
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridAutoRows [
	^ self getProperty:#grid_auto_rows 
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridAutoRows: aString [
	self setProperty:#grid_auto_rows value: aString

				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridColumn [
	^ self getProperty:#grid_column 
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridColumn: aString [
	self setProperty:#grid_column value: aString

				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridGap [
	^ self getProperty:#grid_gap 
				
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridGap: aString [
	self setProperty:#grid_gap value: aString

				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridRow [
	^ self getProperty: #grid_row
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridRow: aString [
	self setProperty:#grid_row value: aString


			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridTemplateAreas [
	^ self getProperty: 	#grid_template_areas 
				
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridTemplateAreas: aString [
	self setProperty:#grid_template_areas value: aString


				
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridTemplateColumns [
	^ self getProperty: 	#grid_template_columns 
			
				
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridTemplateColumns: aString [
	self setProperty:#grid_template_columns value: aString

			
				
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridTemplateRows [
	^ self getProperty: 	#grid_template_rows 
			
				
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> gridTemplateRows: aString [
	self setProperty:#grid_template_rows value: aString

			
				
			
				
				
				
				
]

{ #category : #'state-accessors' }
IPWidget >> handleColor [
	^ self getProperty: #handle_color
]

{ #category : #'state-accessors' }
IPWidget >> handleColor: aString [
	 self setProperty: #handle_color value: aString
]

{ #category : #'state-accessors' }
IPWidget >> height [
	^ self getProperty: #height

]

{ #category : #'state-accessors' }
IPWidget >> height: aString [

	self setProperty: #height value: aString
]

{ #category : #'state-accessors' }
IPWidget >> icon [
	^ self getProperty: #icon

]

{ #category : #'state-accessors' }
IPWidget >> icon: aString [
	self setProperty: #icon value: aString
]

{ #category : #'state-accessors' }
IPWidget >> icons [
	^ self getProperty: #icons 
]

{ #category : #'state-accessors' }
IPWidget >> icons: anArray [
	self setProperty: #icons value: anArray
]

{ #category : #'state-accessors' }
IPWidget >> index [
	^ self getProperty: #index

]

{ #category : #'state-accessors' }
IPWidget >> index: aString [
	self setProperty: #index value: aString
]

{ #category : #'state-accessors' }
IPWidget >> justifyContent [
	^ self getProperty: #justify_content
]

{ #category : #'state-accessors' }
IPWidget >> justifyContent: anObject [
	 self setProperty: #justify_content value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> label [
	| op index |
	index := 0.
	op := self getProperty: #_options_labels.
	index := self getProperty: #index.
	^ op at:(index + 1)
]

{ #category : #'state-accessors' }
IPWidget >> label: aStringOrArray [
	| op index indexes |
	index := 0.
	(aStringOrArray isKindOf:String)
		ifTrue:[ 
			op := self getProperty: #_options_labels.
			index := op indexOf: aStringOrArray.
			self setProperty: #index value: index - 1]
		ifFalse:[
			"must be an array of strings"
			op := self getProperty: #_options_labels.
			indexes := aStringOrArray collect:[:e| (op indexOf: e ) - 1].
			self setProperty: #index value: indexes]
		
]

{ #category : #'state-accessors' }
IPWidget >> layout [
	^ self getProperty: #layout
]

{ #category : #'state-accessors' }
IPWidget >> layout: aLayout [
	self setProperty: #layout value: aLayout
]

{ #category : #'state-accessors' }
IPWidget >> left [
	^ self getProperty: #left
]

{ #category : #'state-accessors' }
IPWidget >> left: anObject [
	self setProperty: #left value: anObject
]

{ #category : #accessing }
IPWidget >> listeners [
	^ listeners ifNil:[listeners := OrderedCollection new]
]

{ #category : #'state-accessors' }
IPWidget >> loop [
	^ self getProperty: #loop
]

{ #category : #'state-accessors' }
IPWidget >> loop: aBool [
	self setProperty: #loop value: aBool
]

{ #category : #'state-accessors' }
IPWidget >> mapping [
	^ self getProperty: #mapping
]

{ #category : #'state-accessors' }
IPWidget >> mapping: aString [
	self setProperty: #mapping value: aString
]

{ #category : #'state-accessors' }
IPWidget >> margin [
	^ self getProperty: #margin
]

{ #category : #'state-accessors' }
IPWidget >> margin: anObject [
	self setProperty: #margin value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> max [
	^ self getProperty: #max
]

{ #category : #'state-accessors' }
IPWidget >> max: aNumber [
	self setProperty: #max value: aNumber
]

{ #category : #'state-accessors' }
IPWidget >> maxHeight [
	^ self getProperty: #max_height
]

{ #category : #'state-accessors' }
IPWidget >> maxHeight: anObject [
	self setProperty: #max_height value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> maxWidth [
	^ self getProperty: #max_width
]

{ #category : #'state-accessors' }
IPWidget >> maxWidth: anObject [
	self setProperty: #max_width value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> messageThrottle [
	^ self getProperty: #msg_throttle
]

{ #category : #'state-accessors' }
IPWidget >> messageThrottle: anInt [

	self setProperty: #msg_throttle value: anInt

]

{ #category : #'state-accessors' }
IPWidget >> min [
	^ self getProperty: #min 
]

{ #category : #'state-accessors' }
IPWidget >> min: aNumber [
	self setProperty: #min value: aNumber
]

{ #category : #'state-accessors' }
IPWidget >> minHeight [
	^ self getProperty: #min_height
]

{ #category : #'state-accessors' }
IPWidget >> minHeight: anObject [
	self setProperty: #min_height value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> minWidth [
	^ self getProperty: #min_width
]

{ #category : #'state-accessors' }
IPWidget >> minWidth: anObject [
	self setProperty: #min_width value: anObject
]

{ #category : #accessing }
IPWidget >> model [
	^ model ifNil:[	model := IPCoreWidgetModelGenerator new]
]

{ #category : #accessing }
IPWidget >> model: anObject [
	model := anObject
]

{ #category : #'state-accessors' }
IPWidget >> modelModule [
	^ self getProperty: #_model_module
]

{ #category : #'state-accessors' }
IPWidget >> modelModuleVersion [
	^ self getProperty:#_model_module_version
]

{ #category : #'state-accessors' }
IPWidget >> modelName [
	^ self getProperty:#_model_name
]

{ #category : #'state-accessors' }
IPWidget >> name [
	^ self getProperty: #name 
]

{ #category : #'state-accessors' }
IPWidget >> name: aString [
	self setProperty: #name value: aString
]

{ #category : #'event-handling' }
IPWidget >> notifyChangeInState: k oldValue:oV newValue:nV [
	|event|
	event := IPStateChangedEvent new 
								sender:self;
								oldValue: oV;
								newValue: nV.
	self listeners do:[:l|
		l valueWithEnoughArguments: {event}].
	^ event
]

{ #category : #'event-handling' }
IPWidget >> onChangingState: aBlockWithOneArgument [
	"argument is the changed property k and v"
	self listeners add:aBlockWithOneArgument 
]

{ #category : #'comm-listener' }
IPWidget >> onDataReceived: data [
	data at:#method ifAbsent:[ ^ self ]. 
	(data at:#method) = 'update' ifTrue:[ self updateState:(data at:#state)].
	(data at:#method) = 'request_state' ifTrue:[ self comm update:self model state].	
]

{ #category : #'comm-actions' }
IPWidget >> openComm [
	self comm targetName: self widgetClass.
	self comm open: self model.
	
]

{ #category : #'state-accessors' }
IPWidget >> options [
	| keys values d |
	keys := self getProperty: #_options_labels.
	values := self getProperty: #_options_values.
	values 
		ifNil:[d:=keys]
		ifNotNil: [  
			d := Dictionary new.
			keys doWithIndex: [:k :i|
			d at:k put: (values at:i)]].
	^ d

]

{ #category : #'state-accessors' }
IPWidget >> options: anObject [
	(anObject isKindOf: Dictionary ) ifTrue:[
		self setProperty: #_options_labels value: anObject keys.
		self setProperty: #_options_values value: anObject values].
	(anObject isKindOf: ArrayedCollection  ) ifTrue:[
		(anObject first isKindOf: String ) 
		ifTrue:[
			self setProperty: #_options_labels value: anObject]
		ifFalse:[
			self setProperty: #_options_labels value: (anObject collect: [:i| i first]).
			self setProperty: #_options_values value: (anObject collect: [:i| i last])]]
					
]

{ #category : #'state-accessors' }
IPWidget >> optionsLabels [
	^ self getProperty: #_options_labels

]

{ #category : #'state-accessors' }
IPWidget >> optionsLabels: anArray [

	self setProperty: #_options_labels value: anArray
]

{ #category : #'state-accessors' }
IPWidget >> order [
	^ self getProperty: #order
]

{ #category : #'state-accessors' }
IPWidget >> order: anObject [
	self setProperty: #order value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> orientation [
	^ self getProperty: #orientation

]

{ #category : #'state-accessors' }
IPWidget >> orientation: aString [

	self setProperty: #orientation value: aString
]

{ #category : #'state-accessors' }
IPWidget >> outputs [
	^ self getProperty: #outputs
]

{ #category : #'state-accessors' }
IPWidget >> outputs: anObject [

	self setProperty: #outputs value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> overflow [
	^ self getProperty: #overflow
]

{ #category : #'state-accessors' }
IPWidget >> overflow: anObject [
"'visible', 'hidden', 'scroll', 'auto', 'inherit', 'initial', 'unset'"
	self setProperty: #overflow value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> overflowX [
	^ self getProperty: #overflow_x
]

{ #category : #'state-accessors' }
IPWidget >> overflowX: anObject [
"'visible', 'hidden', 'scroll', 'auto', 'inherit', 'initial', 'unset'"
	self setProperty: #overflow_x value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> overflowY [
	^ self getProperty: #overflow_y
]

{ #category : #'state-accessors' }
IPWidget >> overflowY: anObject [
"'visible', 'hidden', 'scroll', 'auto', 'inherit', 'initial', 'unset'"	
	self setProperty: #overflow_y value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> padding [
	^ self getProperty: #padding
]

{ #category : #'state-accessors' }
IPWidget >> padding: anObject [

	self setProperty: #padding value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> placeholder [
	^ self getProperty: #placeholder

]

{ #category : #'state-accessors' }
IPWidget >> placeholder: aString [

	self setProperty: #placeholder value: aString
]

{ #category : #'state-accessors' }
IPWidget >> playing [
	^ self getProperty: #_playing

]

{ #category : #'state-accessors' }
IPWidget >> playing: aBoolean [

	self setProperty: #_playing value: aBoolean
]

{ #category : #'state-accessors' }
IPWidget >> pressed [
	^ self getProperty: #pressed

]

{ #category : #'state-accessors' }
IPWidget >> pressed: aBoolean [
	self setProperty: #pressed value: aBoolean
]

{ #category : #'state-accessors' }
IPWidget >> range [
	^ self getProperty: #_range

]

{ #category : #'state-accessors' }
IPWidget >> range: aRange [

	self setProperty: #_range value: aRange
	
]

{ #category : #'state-accessors' }
IPWidget >> readout [
	^ self getProperty: #readout

]

{ #category : #'state-accessors' }
IPWidget >> readout: aString [
	self setProperty: #readout value: aString
]

{ #category : #'state-accessors' }
IPWidget >> readoutFormat [
	^ self getProperty: #readout_format

]

{ #category : #'state-accessors' }
IPWidget >> readoutFormat: aString [
	self setProperty: #readout_format value: aString
]

{ #category : #removing }
IPWidget >> removeListeners [
	self listeners removeAll
]

{ #category : #'state-accessors' }
IPWidget >> repeat [
	^ self getProperty: #_repeat

]

{ #category : #'state-accessors' }
IPWidget >> repeat: aBool [

	self setProperty: #_repeat value: aBool
	
]

{ #category : #'state-accessors' }
IPWidget >> right [
	^ self getProperty: #right
]

{ #category : #'state-accessors' }
IPWidget >> right: anObject [

	self setProperty: #right value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> rows [
	^ self getProperty: #rows

]

{ #category : #'state-accessors' }
IPWidget >> rows: anInt [

	self setProperty: #rows value: anInt
]

{ #category : #'state-accessors' }
IPWidget >> selectedIndex [
	^ self getProperty:#selected_index
]

{ #category : #'state-accessors' }
IPWidget >> selectedIndex: aString [
	^ self setProperty: #selected_index value: aString
]

{ #category : #'remote-notification' }
IPWidget >> sendUpdate: anAssociation [
	
	self comm ifNotNil:[
		self comm send: { 'method'->'update'.
							'state'-> {anAssociation} asDictionary  asSCJsonObject  } asSCJsonObject ]
]

{ #category : #accessing }
IPWidget >> setProperty: aProperty value: aValue [
	| oldValue event aValueCanBeChanged|
	(self stateIncludesKey:aProperty) 
		ifFalse:[MessageNotUnderstood signal: aProperty, ' could not be found']
		ifTrue:[
			oldValue :=self model state at: aProperty.
			event := nil.
			aValueCanBeChanged := aValue.
			self model state at: aProperty put: aValue.
			(oldValue = aValue) ifFalse:[
										event:= self notifyChangeInState: aProperty
														oldValue:oldValue
														newValue:aValue.
										self model state at: aProperty put: event newValue.
										aValueCanBeChanged := event newValue].
			self sendUpdate:( aProperty -> aValueCanBeChanged)]
]

{ #category : #'state-accessors' }
IPWidget >> showRepeat [
	^ self getProperty:#show_repeat

]

{ #category : #'state-accessors' }
IPWidget >> showRepeat: aBool [
	^ self setProperty: #show_repeat value: aBool
]

{ #category : #'state-accessors' }
IPWidget >> sliderColor [
	^ self getProperty: #slider_color

]

{ #category : #'state-accessors' }
IPWidget >> sliderColor: aString [
	^ self setProperty: #slider_color value: aString
]

{ #category : #'state-accessors' }
IPWidget >> source [
	^ self getProperty:#source

]

{ #category : #'state-accessors' }
IPWidget >> source: anArray [
	self setProperty:#source value: anArray
	
]

{ #category : #'state-accessors' }
IPWidget >> stateIncludesKey: aKey [
	^ self model state includesKey: aKey
]

{ #category : #'state-accessors' }
IPWidget >> step [
	^ self getProperty:#step
]

{ #category : #'state-accessors' }
IPWidget >> step: aNumber [
	^ self setProperty: #step value: aNumber
]

{ #category : #'state-accessors' }
IPWidget >> style [
	^ self getProperty: #style

]

{ #category : #'state-accessors' }
IPWidget >> style: anObject [
	^ self setProperty: #style value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> target [
	^ self getProperty:#target
]

{ #category : #'state-accessors' }
IPWidget >> target: anArray [
	^ self setProperty: #target value: anArray
]

{ #category : #'state-accessors' }
IPWidget >> timestamp [
	^ self getProperty: #timestamp 
]

{ #category : #'state-accessors' }
IPWidget >> timestamp:  aFloat [
	^ self setProperty: #timestamp value: aFloat
]

{ #category : #'state-accessors' }
IPWidget >> titles [
	^ self getProperty: #_titles
]

{ #category : #'state-accessors' }
IPWidget >> tooltip [
	^ self getProperty:#tooltip
]

{ #category : #'state-accessors' }
IPWidget >> tooltip: anObject [
	^ self setProperty: #tooltip value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> tooltips [
	^ self getProperty:#tooltips
]

{ #category : #'state-accessors' }
IPWidget >> tooltips: anObject [
	^ self setProperty: #tooltips value: anObject
]

{ #category : #'state-accessors' }
IPWidget >> top [
	^ self getProperty: #top
]

{ #category : #'state-accessors' }
IPWidget >> top: anObject [

	self setProperty: #top value: anObject
]

{ #category : #'remote-update' }
IPWidget >> updateState: aJsonDict [
	| oldValue event newValue|
	aJsonDict keysDo:[:k| 
		oldValue :=self model state at: k.
		newValue := (aJsonDict at:k).
		self model state at:k put: newValue.
		(oldValue = newValue) ifFalse:[
			event :=self notifyChangeInState: k
						oldValue: oldValue
						newValue: newValue.
			newValue := event newValue].
		self model state at:k put: event newValue.
		"if you Change the value in the event block, it must be notified to the client"
		event newValue = newValue ifFalse:[self sendUpdate:( k -> event newValue)] ]
		
]

{ #category : #'state-accessors' }
IPWidget >> value [
	^ self getProperty:#value
]

{ #category : #accessing }
IPWidget >> value: aValue [

	self setProperty:#value value: aValue

]

{ #category : #'state-accessors' }
IPWidget >> viewModule [
	^self getProperty:#_view_module
]

{ #category : #'state-accessors' }
IPWidget >> viewModuleVersion [
	^ self getProperty:#_view_module_version
]

{ #category : #'state-accessors' }
IPWidget >> viewName [
	^ self getProperty:#_view_name
]

{ #category : #'state-accessors' }
IPWidget >> visibility [
	^ self getProperty: #visibility
]

{ #category : #'state-accessors' }
IPWidget >> visibility: anObject [
"'visible', 'hidden', 'inherit', 'initial', 'unset'"
	self setProperty: #visibility value: anObject
]

{ #category : #accessing }
IPWidget >> widgetClass [
	^'jupyter.widget'
]

{ #category : #'state-accessors' }
IPWidget >> width [
	^ self getProperty: #width

]

{ #category : #'state-accessors' }
IPWidget >> width: aString [

	self setProperty: #width value: aString
]
