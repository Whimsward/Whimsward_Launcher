class_name ThesisRecitation extends VBoxContainer
##Used to display a Thesis and its contents.

@export var title : Label
@export var summary : RichTextLabel
@export var content : RichTextLabel

var terms : Thesis = preload("res://Ardor and the World Undone/Path of the Digger/narrative/terms.tres")

func _on_content_label_meta_clicked(meta):
	if meta:
		pass


func _on_summary_label_meta_clicked(meta):
	print_debug(meta)


##Search the Terms Thesis for reference to the string.
func search_terms(ref : String):
	return terms.search(ref)


func _on_content_label_meta_hover_ended(meta):
	if meta:
		return meta
