extends PanelContainer

signal chose_act(id)
signal chose_mance(id)
signal chose_move
signal move_dir(dir : Vector2)
signal move_ended
signal turn_executed

var move_input : bool = false


@onready var act_head = $VBoxContainer/HBoxContainer/ActHead
@onready var mance_head = $VBoxContainer/HBoxContainer/ManceHead
@onready var hovered_tile = $VBoxContainer/HoveredTileLabel
@onready var end_move_button = $VBoxContainer/HBoxContainer/EndMoveButton
@onready var item_list = $VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/ItemList

func display_move(enc : Encounter):
	if not item_list.item_count > 0:
		for tile in enc.get_move():
			update_move(tile)


func update_move(tile : Vector2i):
	item_list.add_item(str(tile))


func refresh_move(enc : Encounter):
	print_debug("Clearing Item List")
	item_list.clear()
	display_move(enc)


func display_tile(txt : String):
	hovered_tile.text = txt


#region Signal Responses

func _on_act_chosen(id):
	chose_act.emit(id)


func _on_mance_chosen(id):
	chose_mance.emit(id)


func _on_move_button_button_up():
	chose_move.emit()
	if not move_input:
		move_input = true
		end_move_button.show()
	if move_input:
		print_debug("You already clicked this.")


func _on_act_head_about_to_popup():
	if not act_head.get_popup().id_pressed.is_connected(_on_act_chosen):
		act_head.get_popup().id_pressed.connect(_on_act_chosen)


func _on_mance_head_about_to_popup():
	if not mance_head.get_popup().id_pressed.is_connected(_on_mance_chosen):
		mance_head.get_popup().id_pressed.connect(_on_mance_chosen)


func _on_move_button_gui_input(event : InputEvent):
	if move_input:
		if event.is_action_pressed("Left"):
			accept_event()
			move_dir.emit(Vector2.LEFT)
		if event.is_action_pressed("Right"):
			move_dir.emit(Vector2.RIGHT)
			accept_event()
		if event.is_action_pressed("Up"):
			move_dir.emit(Vector2.UP)
			accept_event()
		if event.is_action_pressed("Down"):
			move_dir.emit(Vector2.DOWN)
			accept_event()
		if event.is_action_pressed("primary"):
			move_dir.emit(get_global_mouse_position())


func _on_end_move_button_button_up():
	move_input = false
	move_ended.emit()
	end_move_button.hide()
#endregion


func _on_execute_button_button_up():
	turn_executed.emit()
