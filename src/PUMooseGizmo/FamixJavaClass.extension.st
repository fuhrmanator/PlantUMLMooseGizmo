Extension { #name : #FamixJavaClass }

{ #category : #'*PUMooseGizmo' }
FamixJavaClass >> printOnGizmo: aStream [ self isInterface ifTrue: [ aStream << 'interface "' ] ifFalse: [ aStream << 'class "' ]
]
