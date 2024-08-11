class_name Argument extends Resource
##Punched out from Thesis because it's not instantiating as a subclass.


@export_multiline var gloss : Dictionary = {
	"Tag" : "Element",
	"Text" : "Contents"}


##Static function to express a Dictionary as Label and LineEdit Controls using visualize.
static func compel_recitation(dict : Dictionary,target : Control):
	var redict = dict.duplicate()
	for e in redict:
		if redict[e] is Dictionary:
			var edict = redict[e]
			for key in edict:
				Argument.visualize(key,edict[key],target)
		else: Argument.visualize(e,redict[e],target)


##Static function to express a key:value pair as a Label and LineEdit.
static func visualize(key : String, value : String, target : Control):
	var label = Label.new()
	var edit = LineEdit.new()
	label.text = key
	target.add_child(label)
	edit.placeholder_text = value
	edit.expand_to_text_length = true
	target.add_child(edit)
