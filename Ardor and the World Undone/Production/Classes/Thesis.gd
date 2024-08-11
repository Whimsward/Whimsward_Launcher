class_name Thesis extends Resource
##A resource class for storing text data particularly for reference building the project
##and drawing on for dialogue and other game text.

@export var title : String #The title of the Thesis
@export var summary : Argument #The short version of what the Thesis holds.
@export var arguments : Array[Argument] #The partitioned sections of the Thesis.

#Post-refactor, a Thesis should be checking through a copy of an Argument's personal
#Dictionary to facilitate as needed, and otherwise carries a specific Argument's Dictionary
#by reference to that Argument.

func has_in_summary(ref : String) -> bool: #Check if the summary argument gloss has ref
	if summary.gloss.has("Tag"):
		if summary.gloss["Tag"].contains(ref):
			return true
		else: return false
	else: return false


func has_in_arguments(ref : String) -> bool: #Check if the other arguments have ref
	var result : bool = false
	for a : Argument in arguments:
		if a.gloss.has("Tag"):
			if a.gloss["Tag"].contains(ref):
				result = true
	return result


func has_reference(ref : String) -> bool: #Check if any part of the Thesis has ref
	if has_in_summary(ref) or has_in_arguments(ref):
		return true
	else: return false


func get_ref_text(ref : String,in_arg : bool = true):
	var result : String = ""
	if in_arg and has_in_arguments(ref):
		for a : Argument in arguments:
			if a.gloss["Tag"].contains(ref):
				result = a.gloss["Text"]

	elif has_in_summary(ref):
		result = summary.gloss["Text"]
	return result
