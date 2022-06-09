Class {
	#name : #BaselineOfPUMooseGizmo,
	#superclass : #BaselineOf,
	#category : #BaselineOfPUMooseGizmo
}

{ #category : #'as yet unclassified' }
BaselineOfPUMooseGizmo >> badConfig [

	Warning signal: 'This version requires Pharo/Moose 9'.
]

{ #category : #baselines }
BaselineOfPUMooseGizmo >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [
			"Dependencies"
			spec
				for:
				#( 'pharo8.x' 'pharo7.x' 'pharo6.x' 'pharo5.x' 'pharo4.x'
				   'pharo3.x' )
				do: [ self badConfig ].
			spec
				baseline: 'PlantUMLBridge'
				with: [ 
				spec repository: 'github://fuhrmanator/PlantUMLBridge:master/src' ].
			"Packages"
			spec
				package: 'PUMooseGizmo';
				package: 'PUMooseGizmo-Tests'
				with: [ spec requires: #( 'PUMooseGizmo' ) ] ]
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
