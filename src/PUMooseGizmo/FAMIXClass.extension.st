Extension { #name : #FAMIXClass }

{ #category : #'*PUMooseGizmo' }
FAMIXClass >> printOnGizmo: aStream [	self isInterface		ifTrue: [ aStream << 'interface "' ]		ifFalse: [ aStream << 'class "' ]
]
