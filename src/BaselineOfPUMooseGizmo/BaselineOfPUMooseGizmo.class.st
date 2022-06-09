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
	spec for: #common do: [ 
		spec for: #'pharo9.x' do: [ 
			"Dependencies"
			spec
				baseline: 'PlantUMLBridge'
				with: [ 
				spec repository: 'github://fuhrmanator/PlantUMLBridge:master/src' ].
			"Packages"
			spec
				package: 'PUMooseGizmo';
				package: 'PUMooseGizmo-Tests'
				with: [ spec requires: #( 'PUMooseGizmo' ) ] ].
		spec
			for:
			#( #'pharo10.x' #'pharo8.x' #'pharo7.x' #'pharo6.x' #'pharo5.x' #'pharo4.x'
			   #'pharo3.x' )
			do: [ self badConfig ] ]
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
