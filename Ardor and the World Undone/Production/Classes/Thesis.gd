class_name Thesis extends Resource
##A resource class for storing text data particularly for reference building the project
##and drawing on for dialogue and other game text.

@export var title : String #The title of the Thesis
@export var summary : Argument #The short version of what the Thesis holds.
@export var arguments : Array[Argument]

##Call seeker functions on all of the Thesis' Arguments.
func search(ref : String):
	if summary.refer(ref):
		return summary.refer(ref)
	elif summary.deep_dive(ref):
		return summary.deep_dive(ref)                                                                             
	else:
		for A in arguments:
			if A.refer(ref):
				return A
			elif A.deep_dive(ref):
				return A.deep_dive(ref)
			else:
				return null #consider Argument.new() instead?
