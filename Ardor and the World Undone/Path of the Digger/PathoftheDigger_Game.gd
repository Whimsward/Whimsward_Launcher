extends Game


#region Setup
@export_group("Setup","set")
@export var set_start : Control
@export var set_enc_screen : PanelContainer
@export var set_thesis : Thesis = preload("res://Ardor and the World Undone/Production/Narrative/path_of_the_digger.tres")
@export var set_actor : Actor
@export var set_vel_label : Label
@export var set_enc_grid : TileMapLayer
@export_file("*.tscn") var scene
#endregion

enum Phase {WANDER, PLAN, ACTION}
@export var phase : Phase:
	set(value):
		phase = value
		if value == Phase.WANDER:
			set_actor.wandering = true
			set_enc_grid.hide()
		else:
			set_actor.wandering = false
			set_enc_grid.show()

@export var current_encounter : Encounter

var move_tile

func _ready():
	print_debug(set_lead.present_verbs())
	if not current_encounter:
		current_encounter = set_enc_grid.encounter
	make_connections()
	pop_thesis()
	assert(user_input.directed.is_connected(_on_user_directed),"Connection failed.")


func _physics_process(_delta):
	if phase == Phase.ACTION:
		lead_go()
	pop_helper_label()
	if Input.is_action_just_pressed("planshift"):
		if phase == Phase.PLAN:
			phase = Phase.WANDER
		else: phase = Phase.PLAN


func pop_helper_label():
	var subj_name = set_actor.name
	var mouse_pos = "Mouse Location: "+str(get_viewport().get_mouse_position())
	var actor_vel = subj_name+" Vel: "+str(set_actor.velocity)
	var act_move = "Move: "+str(set_actor.go.Moves.find_key(set_actor.go.move_state))+"; "
	var act_air = "Air: "+str(set_actor.go.Air.find_key(set_actor.go.air_state))
	var act_jumps = "Jumps :"+str(set_actor.go.jumps_available)
	set_vel_label.text = mouse_pos+"\n"+subj_name+"\n"+actor_vel+"; "+act_move+act_air+"; "+act_jumps


#region Encounter Grid Methods
##"Native" function to convert Vector2 [pos] to a position on the EncounterGrid.
func get_enc_tile(pos : Vector2 = set_actor.position):
	var conver = set_enc_grid.local_to_map(pos)
	return conver


func is_valid_tile(vec : Vector2i) -> bool: ##Check if a tile has collision polygons.
	var tile_data : TileData = $Set/GroundLayer.get_cell_tile_data(vec)
	if tile_data and tile_data.get_collision_polygons_count(0) > 0:
		return false
	else: return true


func validate_move(vec : Vector2i) -> bool:
	if is_valid_tile(vec) and is_valid_tile(set_enc_grid.get_neighbor_cell(vec,TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)):
		return true
	else: return false


##Get the Encounter Grid's currently selected tile or select the Lead's current tile
##Get a move request for the argued direction, then validate it for no collisions
##If valid place the select cursor pattern, otherwise call the Grid's invalid feedback
func encounter_navigate(direction : Vector2):
	var current = set_enc_grid.current_sel
	var req : Vector2i
	if not current:
		current = get_enc_tile()
	#TODO Insert logic to manage move select by mouse
	req = set_enc_grid.get_move_request(direction)
	if validate_move(req):
		set_enc_grid.set_pattern(set_enc_grid.get_neighbor_cell(current,TileSet.CELL_NEIGHBOR_TOP_SIDE),set_enc_grid.anti_cursor)
		set_enc_grid.place_sel_cursor(req)
	else:
		set_enc_grid.invalid()


##Get a move request from the Encounter Grid for argued direction
##Validate the move request, then if valid return Grid's track move for the request
##Otherwise return null
func direct_move(direction : Vector2):
	var req = set_enc_grid.get_move_request(direction)
	if validate_move(req):
		return set_enc_grid.track_move(req)
	else: 
		print_debug("Not that one mate!")
		return null
#endregion


#region Move Methods
func lead_wander(direction : Vector2):
	pass


#TODO Change to instructions in argument
func lead_go():
	var target = current_encounter.get_move_target()
	var local_target = set_enc_grid.map_to_local(target)
	var dir = set_actor.position.direction_to(local_target)

	if current_encounter.get_move().is_empty():
		if not set_enc_grid.process_move(target, get_enc_tile()):
			phase = Phase.PLAN
			set_enc_screen.refresh_move(current_encounter)

	else:
		if set_enc_grid.process_move(target, get_enc_tile()):
			current_encounter.move_next()
		phase = Phase.ACTION

#endregion

#region Thesis Methods
func open_thesis_view():
	if not set_start.visible:
		set_start.show()
	if set_scene.visible:
		set_scene.hide()
		set_cam.enabled = false
	if set_enc_screen.visible:
		if phase == Phase.PLAN:
			set_enc_screen.hide()


func close_thesis_view():
	if set_start.visible:
		set_start.hide()
	if not set_scene.visible:
		set_scene.show()
		set_cam.enabled = true
	if not set_enc_screen.visible:
			set_enc_screen.show()


func pop_thesis():
	var thesrec = set_start.get_child(0)
	if thesrec is ThesisRecitation:
#set the recitation to the appropriate text from the thesis.
		thesrec.title.text = set_thesis.title
		var tag = set_thesis.summary.gloss["Tag"]
		if tag:
			thesrec.summary.text = tag
		else:
			thesrec.summary.text = "Recovery Failed"
		var text = set_thesis.summary.gloss["Text"]
		if text:
			thesrec.content.text = text
		else:
			thesrec.content.text = "Recovery Failed"
#endregion


#region Signal Responses
func _on_encounter_screen_chose_act(id):
	print_debug("Act chosen: ",id)


func _on_encounter_screen_chose_mance(id):
	print_debug("Mance chosen: ",id)


func _on_encounter_screen_chose_move():
	var current = get_enc_tile()
	#set_enc_grid.place_sel_cursor(current)
	#set_enc_grid.track_move()
	#set_enc_screen.display_move(current_encounter)


func _on_encounter_screen_move_dir(dir : Vector2):
	encounter_navigate(dir)
	direct_move(dir)
	set_enc_screen.refresh_move(current_encounter)


func _on_user_directed(direction : Vector2):
	if phase == Phase.PLAN:
		if direction:
			#encounter_navigate(direction)
			pass
	elif phase == Phase.WANDER:
		pass


func _on_encounter_screen_turn_executed():
	if move_tile:
		phase = Phase.ACTION
		set_enc_screen.refresh_move(current_encounter)


func _on_encounter_screen_move_ended():
	if current_encounter.current_instr.movements:
		var step = current_encounter.current_instr.exe_move()
		print_debug(step)
		set_enc_screen.refresh_move(current_encounter)
		move_tile = step
#endregion
