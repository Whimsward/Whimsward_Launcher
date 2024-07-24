class_name DialogUI
extends Control

signal submitted(selection : Array)

@export_dir var disp_dir : String

@onready var inv_list = $PanelContainer/VBoxContainer/HBoxContainer/InvList
@onready var checkbox_stack = $PanelContainer/VBoxContainer/HBoxContainer/CheckboxStack
@onready var submit_button = $PanelContainer/VBoxContainer/SubmitButton

func _ready():
	hide()
	load_display()


func _process(_delta):
	align_checkboxes()
	if inv_list.item_count == 0:
		submit_button.text = "Confirm No Items Found"
	else: submit_button.text = "Submit"


func load_display():
	var selection = DirAccess.get_files_at(disp_dir)
	for item in selection:
		var inv_length : int = inv_list.custom_minimum_size.x * 10
		inv_list.add_item(item)
		if item.length() * 10 > inv_length:
			inv_length = item.length() * 10
			inv_list.custom_minimum_size.x = inv_length

	for n in inv_list.item_count:
		if checkbox_stack.get_child_count() < inv_list.item_count:
			var checkbox : CheckBox = CheckBox.new()
			checkbox_stack.add_child(checkbox)
			checkbox.text = str(n)


func align_checkboxes():
	if inv_list.is_anything_selected():
		for box in checkbox_stack.get_children():
			if inv_list.is_selected(int(box.text)):
				box.button_pressed = true
			else: box.button_pressed = false
	else:
		for box in checkbox_stack.get_children():
			box.button_pressed = false


func _on_submit_button_pressed():
	submitted.emit(inv_list.get_selected_items())
	hide()
