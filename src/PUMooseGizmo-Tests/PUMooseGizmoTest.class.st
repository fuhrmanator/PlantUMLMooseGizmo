"
A PUGizmoForMooseTest is a test class for testing the behavior of PUGizmoForMoose
"
Class {
	#name : #PUMooseGizmoTest,
	#superclass : #SpSpecTest,
	#instVars : [
		'models'
	],
	#category : #'PUMooseGizmo-Tests'
}

{ #category : #running }
PUMooseGizmoTest >> classToTest [
	^ PUMooseGizmo 
]

{ #category : #models }
PUMooseGizmoTest >> lanModel [
	^ '(
	(Famix-Java-Entities.ParameterizedType (id: 1)
		(name ''Comparable'')
		(isStub true)
		(parameterizableClass (ref: 35))
		(typeContainer (ref: 18)))
	(Famix-Java-Entities.Access (id: 2)
		(accessor (ref: 16))
		(isWrite true)
		(variable (ref: 14)))
	(Famix-Java-Entities.Access (id: 3)
		(accessor (ref: 16))
		(previous (ref: 4))
		(variable (ref: 21)))
	(Famix-Java-Entities.Access (id: 4)
		(accessor (ref: 16))
		(isWrite true)
		(previous (ref: 2))
		(variable (ref: 28)))
	(Famix-Java-Entities.Class (id: 5)
		(name ''A'')
		(modifiers ''public'')
		(typeContainer (ref: 23)))
	(Famix-Java-Entities.Inheritance (id: 6)
		(subclass (ref: 32))
		(superclass (ref: 30)))
	(Famix-Java-Entities.Inheritance (id: 7)
		(previous (ref: 33))
		(subclass (ref: 32))
		(superclass (ref: 1)))
	(Famix-Java-Entities.IndexedFileAnchor (id: 9)
		(element (ref: 3))
		(endPos 172)
		(fileName ''A.java'')
		(startPos 169))
	(Famix-Java-Entities.IndexedFileAnchor (id: 10)
		(element (ref: 16))
		(endPos 180)
		(fileName ''A.java'')
		(startPos 113))
	(Famix-Java-Entities.IndexedFileAnchor (id: 11)
		(element (ref: 22))
		(endPos 96)
		(fileName ''A.java'')
		(startPos 93))
	(Famix-Java-Entities.Method (id: 12)
		(name ''getName'')
		(cyclomaticComplexity 1)
		(declaredType (ref: 32))
		(modifiers ''public'')
		(numberOfStatements 1)
		(parentType (ref: 5))
		(signature ''getName()''))
	(Famix-Java-Entities.PrimitiveType (id: 13)
		(name ''void'')
		(isStub true))
	(Famix-Java-Entities.ImplicitVariable (id: 14)
		(name ''self'')
		(isStub true)
		(parentBehaviouralEntity (ref: 16)))
	(Famix-Java-Entities.IndexedFileAnchor (id: 15)
		(element (ref: 2))
		(endPos 165)
		(fileName ''A.java'')
		(startPos 157))
	(Famix-Java-Entities.Method (id: 16)
		(name ''setName'')
		(cyclomaticComplexity 1)
		(declaredType (ref: 13))
		(modifiers ''public'')
		(numberOfStatements 2)
		(parentType (ref: 5))
		(signature ''setName(String)''))
	(Famix-Java-Entities.IndexedFileAnchor (id: 17)
		(element (ref: 21))
		(endPos 143)
		(fileName ''A.java'')
		(startPos 133))
	(Famix-Java-Entities.Inheritance (id: 19)
		(subclass (ref: 5))
		(superclass (ref: 30)))
	(Famix-Java-Entities.IndexedFileAnchor (id: 20)
		(element (ref: 28))
		(endPos 41)
		(fileName ''A.java'')
		(startPos 38))
	(Famix-Java-Entities.Parameter (id: 21)
		(name ''name'')
		(declaredType (ref: 32))
		(parentBehaviouralEntity (ref: 16)))
	(Famix-Java-Entities.Access (id: 22)
		(accessor (ref: 12))
		(variable (ref: 28)))
	(Famix-Java-Entities.Class (id: 24)
		(name ''CharSequence'')
		(isInterface true)
		(isStub true)
		(modifiers ''public'')
		(typeContainer (ref: 18)))
	(Famix-Java-Entities.Inheritance (id: 25)
		(previous (ref: 7))
		(subclass (ref: 32))
		(superclass (ref: 24)))
	(Famix-Java-Entities.IndexedFileAnchor (id: 26)
		(element (ref: 4))
		(endPos 165)
		(fileName ''A.java'')
		(startPos 157))
	(Famix-Java-Entities.SourceLanguage (id: 27))
	(Famix-Java-Entities.Attribute (id: 28)
		(name ''name'')
		(declaredType (ref: 32))
		(modifiers ''private'')
		(parentType (ref: 5)))
	(Famix-Java-Entities.IndexedFileAnchor (id: 29)
		(element (ref: 12))
		(endPos 104)
		(fileName ''A.java'')
		(startPos 51))
	(Famix-Java-Entities.Class (id: 30)
		(name ''Object'')
		(isStub true)
		(typeContainer (ref: 18)))
	(Famix-Java-Entities.IndexedFileAnchor (id: 31)
		(element (ref: 5))
		(endPos 183)
		(fileName ''A.java'')
		(startPos 1))
	(Famix-Java-Entities.Class (id: 32)
		(name ''String'')
		(isStub true)
		(modifiers ''public'' ''final'')
		(typeContainer (ref: 18)))
	(Famix-Java-Entities.Inheritance (id: 33)
		(previous (ref: 6))
		(subclass (ref: 32))
		(superclass (ref: 34)))
	(Famix-Java-Entities.Class (id: 34)
		(name ''Serializable'')
		(isInterface true)
		(isStub true)
		(modifiers ''public'')
		(typeContainer (ref: 8)))
	(Famix-Java-Entities.ParameterizableClass (id: 35)
		(name ''Comparable'')
		(isInterface true)
		(isStub true)
		(modifiers ''public'')
		(typeContainer (ref: 18)))
	)'
]

{ #category : #setup }
PUMooseGizmoTest >> mooseModels [
	models := OrderedCollection new.
	models
		add: (FamixJavaModel importFromMSEStream: self lanModel readStream);
		add: (FamixJavaModel importFromMSEStream: self simpleModel readStream).
	models first name: 'First-lanModel'.
	models second name: 'Second-simpleModel'.
]

{ #category : #setup }
PUMooseGizmoTest >> setUp [
	super setUp.
	presenter := PUMooseGizmo new.
	self mooseModels.
	presenter modelList items: models.
	presenter modelList selectIndex: 1.
]

{ #category : #models }
PUMooseGizmoTest >> simpleModel [
	^ '(
		(Famix-Java-Entities.Package (id: 100) (name ''aPackage''))				
		(Famix-Java-Entities.Class (id: 1) (name ''AClass''))
		(Famix-Java-Entities.Class (id: 10) (name ''AnotherClass''))
		(Famix-Java-Entities.Method (id: 2) (name ''aMethod'') (parentType (ref: 1)))
		(Famix-Java-Entities.Class (id: 3) (name ''AnAnnotationDefinitionClass''))
		(Famix-Java-Entities.AnnotationType (id: 4) (name ''AnAnnotation'') (typeContainer (ref: 100)))
		(Famix-Java-Entities.Class (id: 5) (name ''AnotherAnnotationDefinitionClass''))
		(Famix-Java-Entities.AnnotationType (id: 6) (name ''AnotherAnnotation'') (typeContainer (ref: 100)))
		(Famix-Java-Entities.AnnotationInstance (id: 7) (annotatedEntity (ref: 1)) (annotationType (ref: 4)))
		(Famix-Java-Entities.AnnotationInstance (id: 8) (annotatedEntity (ref: 10)) (annotationType (ref: 4)))
		(Famix-Java-Entities.AnnotationInstance (id: 9) (annotatedEntity (ref: 2)) (annotationType (ref: 6)))
	)'
]

{ #category : #tests }
PUMooseGizmoTest >> testFilterClasses [

	| items filterText |
	filterText := 'each name beginsWith:''P'''.
	items := presenter classTable items select: [ :each | 
		         each name beginsWith: 'P' ].
	presenter filter text: filterText.
	self assert: presenter classTable items size equals: items size.
	presenter classTable items do: [ :each | 
		self assert: (each name beginsWith: 'P') ]
]

{ #category : #tests }
PUMooseGizmoTest >> testSelectClasses [
	presenter classTable selectIndexes: {1 . 3}.
	self
		assert:
			presenter selectionTable items
				isEmpty .
	presenter selectClasses.
	self
		assert:
			(presenter selectionTable items
				includes: presenter classTable items first).
	self
		deny:
			(presenter selectionTable items
				includes: presenter classTable items second).
	self
		assert:
			(presenter selectionTable items
				includes: presenter classTable items third)
]

{ #category : #tests }
PUMooseGizmoTest >> testUnselectClasses [
	presenter classTable selectIndex: 1.
	presenter selectClasses.
	self assert: presenter selectionTable items isNotEmpty.
	self
		assert:
			(presenter selectionTable items
				includes: presenter classTable items first).
					presenter selectionTable selectIndex: 1.
	presenter unselectClasses.
	self
		deny:
			(presenter selectionTable items
				includes: presenter classTable items first).
]

{ #category : #tests }
PUMooseGizmoTest >> testUpdateClassListWhenModelListIsChanged [
	| classes |
	classes := presenter classTable items.
	presenter modelList selectIndex: 2.
	self deny: presenter classTable items size equals: classes size.
	self
		deny: presenter classTable items first name
		equals: classes first name.
	presenter modelList selectIndex: 1.
	self assert: presenter classTable items size equals: classes size.
	self
		assert: presenter classTable items first name
		equals: classes first name
]
