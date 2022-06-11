Class {
	#name : #PUMooseGizmo,
	#superclass : #SpPresenter,
	#instVars : [
		'modelList',
		'classTable',
		'selectionTable',
		'filter',
		'getTheDiagramButton',
		'preferenceButton',
		'diagram',
		'resizeCheckBox',
		'attributeCheckBox',
		'methodCheckBox',
		'inheritanceCheckBox',
		'aggregationCheckBox',
		'createCheckBox',
		'preferencePresenter',
		'preference',
		'pUMLSource',
		'copySourceButton',
		'items',
		'selectedClasses',
		'pUMLBridge'
	],
	#category : #PUMooseGizmo
}

{ #category : #'as yet unclassified' }
PUMooseGizmo class >> constructorsForMooseClass: mClass [
	"Find the constructors for a class"
	^ mClass methods select: [ :m | m isConstructor]

]

{ #category : #'as yet unclassified' }
PUMooseGizmo class >> creatorsForMooseClass: mClass [
	"Find the creators for a class"

	| constructors creators |
	constructors := self constructorsForMooseClass: mClass.
	creators := constructors
		collect:
			[ :method | method incomingInvocations collect: [ :ii | ii sender parentType ] ].
	^ creators flattened
]

{ #category : #layout }
PUMooseGizmo class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 60 percent;
		  add: (SpPanedLayout newHorizontal
				   positionOfSlider: 70 percent;
				   add: (SpBoxLayout newVertical
						    add: (SpPanedLayout newHorizontal
								     positionOfSlider: 30 percent;
								     add: #modelList;
								     add: #classTable);
						    add: ''
						    withConstraints: [ :constraints | constraints height: 0 ];
						    add: (SpBoxLayout newHorizontal
								     add: 'Filter: [ :each | '
								     withConstraints: [ :constraints | constraints width: 80 ];
								     add: #filter;
								     add: ' ]'
								     withConstraints: [ :constraints | constraints width: 15 ])
						    withConstraints: [ :constraints | 
						    constraints height: self toolbarHeight ]);
				   add: (SpBoxLayout newVertical
						    add: #selectionTable;
						    add: ''
						    withConstraints: [ :constraints | constraints height: 0 ];
						    add: #getTheDiagramButton
						    withConstraints: [ :constraints | 
							    constraints height: self toolbarHeight ]));
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal
						    add: #attributeCheckBox;
						    add: #methodCheckBox;
						    add: #inheritanceCheckBox;
						    add: #aggregationCheckBox;
						    add: #createCheckBox)
				   withConstraints: [ :constraints | 
				   constraints height: self toolbarHeight ];
				   add: #diagram;
				   "Might work in the future"add: (SpBoxLayout newHorizontal
						    add: #resizeCheckBox;
						    add: #preferenceButton;
						    add: #copySourceButton)
				   withConstraints: [ :constraints | 
				   constraints height: self toolbarHeight ]);
		  yourself
]

{ #category : #examples }
PUMooseGizmo class >> open [

	<example>
	<mooseTool: #'PlantUML Gizmo'>
	self new open
]

{ #category : #'as yet unclassified' }
PUMooseGizmo class >> plantUMLSourceForMooseClasses: classes [
	^ self
		plantUMLSourceForMooseClasses: classes
		withPreference: ''
		withRelationships: {true . true . true . true . true}
]

{ #category : #api }
PUMooseGizmo class >> plantUMLSourceForMooseClasses: classes withPreference: preference withRelationships: aCollection [
	"A utility method with Moose. e.g.:
	| classes pUMLSource commaFlag |
	classes := (MooseModel root first allClasses reject:#isStub) 
		select: [:c | c mooseName beginsWith: 'headfirst::designpatterns::factory::pizzaaf'].
	pUMLSource := PUGizmo plantUMLSourceForMooseJavaClasses: classes.
	key := pUMLSource asPlantUMLKey.
	serverUrl := 'http://localhost:8080/plantuml/img/', key .
	imageMorph := (ZnEasy getPng: serverUrl asUrl) asAlphaImageMorph .
	imageMorph layout: #scaledAspect.
	w := imageMorph openInWindow.
	w center; fitInWorld.	
	"

	"aCollection = {attributes . methods. inheritance . aggregation . create}"

	^ String
		new: 400
		streamContents: [ :stream | 
			self startUMLWithStream: stream.
			preference
				ifNotEmpty: [ stream
						<< preference;
						cr ].
			classes
				doWithIndex: [ :class :i | 
					self printNameWithClass: class withStream: stream.
					(aCollection first or:[aCollection second]) ifTrue:[stream
						<< '{';
						cr.
					aCollection first
						ifTrue: [ self printAttributesWithClass: class withStream: stream ].
					aCollection second
						ifTrue: [ self printMethodsWithClass: class withStream: stream ].
					stream
						<< '}';
						cr ]].

			"inheritance relations"
			aCollection third
				ifTrue: [ classes
						do: [ :class | self printInheritanceWithClass: class withStream: stream ] ].
			aCollection fourth
				ifTrue: [ classes
						do: [ :class | self printAggregationWithClass: class withStream: stream ] ].

			"creates relations"
			aCollection fifth
				ifTrue: [ classes
						do: [ :class | self printCreateWithClass: class withStream: stream ] ].

			"The end"
			stream
				<< '@enduml';
				cr ]
]

{ #category : #printing }
PUMooseGizmo class >> printAggregationWithClass: aClass withStream: aStream [
	| aggregates |
	aggregates := (aClass attributes collect: #declaredType) reject: #isNil.
	aggregates
		ifNotEmpty: [ (aggregates reject: #isStub)
				do: [ :agg | 
					aStream
						<< '"';
						<< agg mooseName;
						<< '"'.
					aStream << ' --o '.
					aStream
						<< '"';
						<< aClass mooseName;
						<< '"';
						cr ] ]
]

{ #category : #printing }
PUMooseGizmo class >> printAttributesWithClass: aClass withStream: aStream [
	aClass attributes
		do: [ :attribute | 
			aStream
				<< attribute name;
				cr ]
]

{ #category : #printing }
PUMooseGizmo class >> printCreateWithClass: aClass withStream: aStream [
	| creators |
	creators := self creatorsForMooseClass: aClass.
	creators
		do: [ :creator | 
			aStream
				<< '"';
				<< creator mooseName;
				<< '"'.
			aStream << ' ..> '.
			aStream
				<< '"';
				<< aClass mooseName;
				<< '"'.
			aStream
				<< ' : "<<creates>>" ';
				cr ]
]

{ #category : #printing }
PUMooseGizmo class >> printInheritanceWithClass: aClass withStream: aStream [
	(aClass directSuperclasses reject: #isStub)
		do: [ :superClass | 
			aStream
				<< '"';
				<< superClass mooseName;
				<< '"'.
			((superClass class selectors includes: #isInterface)
				and: [ superClass isInterface ])
				ifTrue: [ aStream << ' <|.. ' ]
				ifFalse: [ aStream << ' <|-- ' ].
			"superClass isInterface"
			aStream
				<< '"';
				<< aClass mooseName;
				<< '"';
				cr ]
]

{ #category : #printing }
PUMooseGizmo class >> printMethodsWithClass: aClass withStream: aStream [
	aClass methods
		do: [ :method | 
			aStream
				<< method name;
				<< '()';
				cr ]
]

{ #category : #printing }
PUMooseGizmo class >> printNameWithClass: aClass withStream: aStream [
	"aClass printOnGizmo: aStream."
	((aClass class selectors includes: #isInterface)
		and: [ aClass isInterface ])
		ifTrue: [ aStream << 'interface "' ]
		ifFalse: [ aStream << 'class "' ].
	aStream
		<< aClass mooseName;
		<< '"';
		cr
]

{ #category : #printing }
PUMooseGizmo class >> startUMLWithStream: aStream [
	aStream
		<< '@startuml';
		cr

]

{ #category : #action }
PUMooseGizmo >> buildBlockFrom: aString [
[ ^self class compiler evaluate: '[ :each | ' , aString , ']' ]
		on: SyntaxErrorNotification
		do: [ ^ [  ] ].

]

{ #category : #menu }
PUMooseGizmo >> classListMenu [
	^ self newMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'Select';
						action: [ self selectClasses ] ] ]
]

{ #category : #accessing }
PUMooseGizmo >> classTable [
	"For the test"

	^ classTable
]

{ #category : #action }
PUMooseGizmo >> copyUMLCode [
	Clipboard clipboardText: pUMLSource.
	self inform: 'Copy'
]

{ #category : #accessing }
PUMooseGizmo >> filter [
	"For the test"

	^ filter
]

{ #category : #initialization }
PUMooseGizmo >> initialExtent [ 
	| fontWidth rowHeight |
	fontWidth := StandardFonts defaultFont widthOfString: 'M'.
	rowHeight := self class inputTextHeight.
	^ 100 @ 20 * (fontWidth @ rowHeight)
]

{ #category : #initialization }
PUMooseGizmo >> initialize [
	pUMLBridge := PlantUMLBridge new.
	pUMLSource := ''.
	selectedClasses := OrderedCollection new.
	preference := 'set namespaceSeparator ::' , String cr
		, 'hide empty members' , String cr , 'scale 1' , String cr
		, 'left to right direction' , String cr.
	preferencePresenter := PreferencePresenter new.
	super initialize
]

{ #category : #initialization }
PUMooseGizmo >> initializePresenter [

	modelList whenSelectionChangedDo: [ 
		selectedClasses removeAll.
		self updateClasses ].
	filter whenTextChangedDo: [ self updateClasses ].
	getTheDiagramButton action: [ self setDiagram ].
	preferenceButton action: [ self managePreferenceDialog ].
	copySourceButton action: [ self copyUMLCode ].
	resizeCheckBox whenChangedDo: [ :state | 
		diagram autoScale: state not ].
	attributeCheckBox whenChangedDo: [ self updateDiagram ].
	methodCheckBox whenChangedDo: [ self updateDiagram ].
	inheritanceCheckBox whenChangedDo: [ self updateDiagram ].
	aggregationCheckBox whenChangedDo: [ self updateDiagram ].
	createCheckBox whenChangedDo: [ self updateDiagram ]
]

{ #category : #initialization }
PUMooseGizmo >> initializeTables [
	classTable := self newTable
		beMultipleSelection;
		contextMenu: self classListMenu;
		sortingBlock: [ :a :b | a fullPrintString < b fullPrintString ].
	classTable
		addColumn:
			((SpCheckBoxTableColumn
				evaluated: [ :class | selectedClasses includes: class ])
				onActivation: [ :class | 
					selectedClasses add: class.
					self updateSelections ];
				onDeactivation: [ :class | 
					selectedClasses remove: class.
					self updateSelections ];
				width: 20;
				yourself);
		addColumn:
			((SpImageTableColumn evaluated: [:m | MooseIcons mooseIcon])
				width: 20;
				yourself);
		addColumn: (SpStringTableColumn evaluated: #fullPrintString).
	selectionTable := self newTable
		beMultipleSelection;
		contextMenu: self selectionListMenu.
	selectionTable
		addColumn:
			((SpCheckBoxTableColumn
				evaluated: [ :class | selectedClasses includes: class ])
				onDeactivation: [ :class | 
					selectedClasses remove: class.
					self updateSelections ];
				width: 20;
				yourself);
		addColumn:
			((SpImageTableColumn evaluated: [:m | MooseIcons mooseIcon])
				width: 20;
				yourself);
		addColumn: (SpStringTableColumn evaluated: #name)
]

{ #category : #initialization }
PUMooseGizmo >> initializeWidgets [

	self initializeTables.
	modelList := self newList.
	modelList
		items: MooseModel root allModels;
		display: [ :item | item name ];
		displayIcon: [ :item | MooseIcons mooseIcon ];
		sortingBlock: [ :a :b | a name < b name ].
	filter := self newTextInput placeholder: 'each isStub'.
	getTheDiagramButton := self newButton disable
		                       label: 'Get the diagram';
		                       icon: (self iconNamed: #glamorousGo).
	preferenceButton := self newButton disable label: 'Preference'.
	copySourceButton := self newButton disable label:
		                    'Copy current UML code'.
	diagram := self newImage.
	resizeCheckBox := self newCheckBox disable
		                  label: 'Original size';
		                  state: true.
	attributeCheckBox := self newCheckBox disable label: 'Attributes'.
	methodCheckBox := self newCheckBox disable label: 'Methods'.
	inheritanceCheckBox := self newCheckBox disable label: 'Inheritance'.
	aggregationCheckBox := self newCheckBox disable label: 'Aggregation'.
	createCheckBox := self newCheckBox disable label: 'Create'.
	self focusOrder
		add: modelList;
		add: classTable;
		add: selectionTable;
		add: filter
]

{ #category : #initialization }
PUMooseGizmo >> initializeWindow: aWindowPresenter [
	| fontWidth rowHeight |
	fontWidth := StandardFonts defaultFont widthOfString: 'M'.
	rowHeight := self class inputTextHeight.
	aWindowPresenter initialExtent: 110 @ 20 * (fontWidth @ rowHeight).
	aWindowPresenter title: self title
]

{ #category : #action }
PUMooseGizmo >> managePreferenceDialog [
	preferencePresenter preference: preference.
	preferencePresenter openDialogWithSpec
		okAction: [ preference := preferencePresenter preference asString.
			self updateDiagram.
			preferencePresenter window close ]
]

{ #category : #accessing }
PUMooseGizmo >> modelList [
	"For the test"
	^ modelList
]

{ #category : #action }
PUMooseGizmo >> selectClasses [
	selectedClasses addAllFirstUnlessAlreadyPresent: classTable selection selectedItems.
	self updateSelections.
]

{ #category : #menu }
PUMooseGizmo >> selectionListMenu [
	^ self newMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'Unselect';
						action: [ self unselectClasses ] ] ]
]

{ #category : #accessing }
PUMooseGizmo >> selectionTable [
	"For the test"

	^ selectionTable
]

{ #category : #action }
PUMooseGizmo >> setDiagram [
	items := selectedClasses..
	attributeCheckBox enable.
	methodCheckBox enable.
	inheritanceCheckBox enable.
	aggregationCheckBox enable.
	createCheckBox enable.
	resizeCheckBox enable.
	preferenceButton enable.
	copySourceButton enable.
	self updateDiagram.
	getTheDiagramButton disable
]

{ #category : #api }
PUMooseGizmo >> title [
	^'Moose PlantUML Gizmo'
]

{ #category : #action }
PUMooseGizmo >> unselectClasses [
	selectionTable selection selectedItems
		do: [ :each | selectedClasses remove: each ] .self updateSelections
]

{ #category : #action }
PUMooseGizmo >> updateClasses [

	| filterText filterBlock filteredItems normalColor redBg greenBg |
	normalColor := Smalltalk ui theme backgroundColor.
	redBg := normalColor mixed: 0.8 with: Color red.
	greenBg := normalColor mixed: 0.8 with: Color green.

	filterText := filter text.
	filterText
		ifEmpty: [
			filter adapter ifNotNil: [ adapter widget color: normalColor ].
			modelList selection selectedItem
				ifNil: [ filteredItems := {  } ]
				ifNotNil: [ 
				filteredItems := modelList selection selectedItem allClasses ] ]
		ifNotEmpty: [ 
			filterBlock := self buildBlockFrom: filterText.
			[ 
			filteredItems := modelList selection selectedItem allClasses 
				                 select: filterBlock.
			filter adapter ifNotNil: [ filter adapter widget color: greenBg ] ]
				on: Error
				do: [ 
					filteredItems := modelList selection selectedItem allClasses.
					filter adapter ifNotNil: [filter adapter widget color: redBg] ] ].
	classTable items: filteredItems.
	filteredItems
		ifEmpty: [ getTheDiagramButton disable ]
		ifNotEmpty: [ getTheDiagramButton enable ].
	self updateSelections
]

{ #category : #action }
PUMooseGizmo >> updateDiagram [

	| serverUrl |
	pUMLSource := PUMooseGizmo 
		plantUMLSourceForMooseClasses: items
		withPreference: preference
		withRelationships:
			{attributeCheckBox state.
			methodCheckBox state.
			inheritanceCheckBox state.
			aggregationCheckBox state.
			createCheckBox state}.

	"using a local server"
	"serverUrl := 'http://localhost:8080/plantuml/img/'"
	serverUrl := 'https://www.plantuml.com/plantuml/png/'
		, (pUMLBridge urlFromSource: pUMLSource).
	"serverUrl := 'https://www.plantuml.com/plantuml/img/', key ."
	diagram image: (ZnEasy getPng: serverUrl asUrl)
]

{ #category : #action }
PUMooseGizmo >> updateSelections [
	selectionTable items: selectedClasses.
	classTable items: classTable items.
	
	selectedClasses ifEmpty: [ getTheDiagramButton disable]ifNotEmpty:[ getTheDiagramButton enable]
]
