extends Vendor

signal reported

@export var mediator : Node
@export_enum("HBOXCONTAINER","VBOXCONTAINER","PANELCONTAINER","ITEMLIST","GRIDCONTAINER") var card_type

@onready var dialog = $Dialog

func _ready():
	cast_self()
	dock_subvendors()


func cast_self():
	if not mediator:
		mediator = get_parent()
	else: mediator = null
	print(card_type)


func deploy_items():
	pass


func on_item_signalled():
	pass




func _on_show_gui_button_pressed():
	dialog.show()


func _on_dialog_submitted(selection):
	print(selection)


func _on_pause_button_toggled(toggled_on):
	if toggled_on:
		print("Open Pause Menu") #TODO: create func for pause menu, the pause menu, and logic etc.
	else: print("Close Pause Menu")
