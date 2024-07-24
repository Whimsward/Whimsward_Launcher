extends Game

@export var start : Control
@export var thesis : Thesis = preload("res://Ardor and the World Undone/Production/Narrative/path_of_the_digger.tres")

func _ready():
	if start is ThesisRecitation: #set the recitation to the appropriate text from the thesis.
		start.title.text = thesis.title
		start.summary.text = thesis.summary.subtitle+"\n"
		start.content.text = thesis.summary.text

	print_debug(Alignment.confess(thesis.summary.debate()[0]))
