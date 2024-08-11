class_name ThesisRecitation extends VBoxContainer
##Used to display a Thesis and its contents.

signal closed

@export var title : Label
@export var summary : RichTextLabel
@export var content : RichTextLabel
@export var dynamtext : Label

var terms : Thesis = preload("res://Ardor and the World Undone/Path of the Digger/narrative/terms.tres")
var interest : bool = false
var hovered_term : String
var clicked_term : String

@onready var hover_timer = $HoverTimer
@onready var hover_time_display = $HoverTimeDisplay


func _process(_delta):
	var time_conv = 100 * hover_timer.time_left
	if hover_timer.is_stopped():
		hover_time_display.value = 0
	else:
		hover_time_display.value = hover_time_display.max_value - time_conv
	if interest:
		dynamtext.text = hovered_term
	elif clicked_term:
		dynamtext.text = clicked_term


func _on_content_label_meta_clicked(meta):
	print_debug(meta)
	var metastring = str(meta)
	var searched = terms.get_ref_text(metastring)
	if searched:
		clicked_term = metastring+"\n"+searched
	else:
		clicked_term = "Selected term '"+meta+"' currently has no text."


func _on_summary_label_meta_clicked(meta):
	print_debug(meta)
	var metastring = str(meta)
	var searched = terms.get_ref_text(metastring)
	if searched:
		clicked_term = metastring+"\n"+searched
	else:
		clicked_term = "Selected term '"+meta+"' currently has no text."


func _on_content_label_meta_hover_ended(_meta):
	if not hover_timer.time_left == 0:
		hover_timer.stop()
	interest = false
	hovered_term = ""



func _on_content_label_meta_hover_started(meta):
	var metastring = str(meta)
	hover_timer.start()
	var searched = terms.get_ref_text(metastring)
	if searched:
		hovered_term = metastring+"\n"+searched
	else:
		hovered_term = metastring+" ain't got text?"


func _on_hover_timer_timeout():
	interest = true


func _on_close_button_button_up():
	closed.emit()
	hide()
