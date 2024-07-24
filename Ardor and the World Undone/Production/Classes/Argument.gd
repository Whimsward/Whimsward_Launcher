class_name Argument extends Resource
##Punched out from Thesis because it's not instantiating as a subclass.

@export var number : int
@export var subtitle : String #use for heading titles or very simple content
@export_multiline var text : String #use for initial description or internal paragraphs
@export var content : Array[Argument] #allows for nesting subarguments
@export var alignment : Alignment


func amend(txt : String, variant):
	if variant == subtitle:
		subtitle = txt
	if variant == text:
		text = txt


func refer(ref : String):
	if ref in subtitle:
		if text:
			return text
		else:
			return self
	else: return null


func deep_dive(ref : String):
	for A in content:
		if A.refer(ref):
			return A
		else:
			return null #consider Argument.new()


func get_alignment(arg : Argument = self):
	print_debug(Alignment.confess(arg.alignment.aligned))
	var para = Alignment.track_alignment(arg.alignment.aligned)
	return para


func debate():
	var align_array = [alignment.aligned]
	for A in content:
		align_array.append(get_alignment(A))
	return align_array
