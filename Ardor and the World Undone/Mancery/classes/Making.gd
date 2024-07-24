class_name Make extends Resource

@export var query = glossary.duplicate()

const glossary : Dictionary = {
	"Paradigm" : Alignment.Paradigm,
	"Aspect" : Aspect.Vantage,
	"Medium" : ManaSource.Medium,
	"Rite" : Rite.CANT,
	"Violation" : Violation.Assault,
	"Element" : Mote.Element
}

##Confess returns a normally-cased string of the enum key for the index
static func confess(order : Dictionary,index : int) -> String:
	return order.find_key(index).capitalize()

##List returns an Array of confessed strings from an enum
static func list(order : Dictionary) -> Array:
	var loaner : Array = []
	for index in order.values():
		loaner.append(confess(order,index))
	return loaner


static func ref(school : StringName) -> Dictionary:
	return glossary[school]
