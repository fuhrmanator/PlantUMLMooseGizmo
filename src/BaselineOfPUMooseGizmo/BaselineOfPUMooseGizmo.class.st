Class {
	#name : #BaselineOfPUMooseGizmo,
	#superclass : #Object,
	#category : #BaselineOfPUMooseGizmo
}

{ #category : #baselines }
BaselineOfPUMooseGizmo >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			for: #'pharo9.x'
			do: [ 		
					"Dependencies"
					self plantUMLBridge: spec.
					"Packages"
					spec
					package: 'PUMooseGizmo';
					package: 'PUMooseGizmo-Tests'
					with: [ spec requires: #( 'PUMooseGizmo' ) ].		
				 ].
		spec 
			for: #('pharo8.x' 'pharo7.x' 'pharo6.x' 'pharo5.x' 'pharo4.x' 'pharo3.x')
			do: [ UIManager default inform: 'This version requires Pharo/Moose 9' ]
			]
]

{ #category : #'as yet unclassified' }
BaselineOfPUMooseGizmo >> plantUMLBridge: spec [

	spec
		baseline: 'PlantUML Bridge'
		with: [ 
			spec 
				repository: 'github://fuhrmanator/PlantUMLBridge:master/src' 
				]
]
