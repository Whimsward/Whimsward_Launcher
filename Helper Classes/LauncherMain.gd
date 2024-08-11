class_name Main extends Node
##Manages the main flow of the Launcher, trading out scenes and mediating between UI and Canvas.

@onready var main_menu = $MainMenu
@export var game_reg : GameRegister

var current : Game

func open(target : PackedScene):
	var next = target.instantiate()
	if next is Game:
		if current:
			current.replace_by(next)
		else:
			add_child(next)
		current = next


func swap_main_menu():
	if main_menu.visible:
		main_menu.hide()
	elif not main_menu.visible:
		main_menu.show()


func _ready():
	pass # Replace with function body.


##TODO: Open Launcher Main Menu Page (ProjectTabs?)
func _on_start_button_up():
	$Start.hide()
	main_menu.show()


func _on_list_item_activated(list : ItemList,index : int):
	var next
	if list.get_item_text(index) == "run_potd":
		next = open(load(game_reg.games["Path of the Digger"]))
	if list.get_item_text(index) == "run_hrw":
		next = open(game_reg.games["Half-Remembered Wood"])
	swap_main_menu()
	#var pane : ProjectTabs.Pane = list.get_parent()
	#var path = pane.file_path
	#var actuator : String = path+list.get_item_text(index)
	#print_debug(actuator)
	#if actuator.is_absolute_path():
		#var advent = load(actuator)
		#print_debug(advent)
