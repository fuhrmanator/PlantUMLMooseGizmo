Extension { #name : #FamixTClass }

{ #category : #'*PUMooseGizmo' }
FamixTClass >> printOnGizmo: aStream [	self isInterface		ifTrue: [ aStream << 'interface "' ]		ifFalse: [ aStream << 'class "' ]
]
