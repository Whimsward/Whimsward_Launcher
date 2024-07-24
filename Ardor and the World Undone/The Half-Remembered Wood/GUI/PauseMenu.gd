extends PanelContainer

signal options_selected

@export var options : Array[bool]= []


func _on_accept_button_pressed():
	#for option in pause_options.get_children():
		#options.append(option.button_pressed)
	hide()
