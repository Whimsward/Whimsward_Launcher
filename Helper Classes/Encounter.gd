class_name Encounter extends Resource
##

enum MapLayers {MAIN=1,BACKGROUND,FOREGROUND,ENCOUNTER}


@export var description : Thesis
@export var entities_on_field : Array[Character]

##@experimental hold TileMap coordinates
@export var map : Dictionary = {
	"Main" : {},
	"Background" : {},
	"Foreground" : {},
	"Encounter" : {}
	}
@export var current_instr : Instructions

func get_move_target(instr : Instructions = current_instr):
	if instr.move_target:
		return instr.move_target
	else: return null

func build_instructions() -> Instructions:
	var instr = Instructions.new()
	if not current_instr:
		current_instr = instr
		return current_instr
	else: return instr


func start_move(tile : Vector2i, instr : Instructions = build_instructions(), set_recall : Vector2i = Vector2i(0,0)) -> Array[Vector2i]:
	if set_recall.x == 1:
		if set_recall.y == 1:
			instr.has_recall = true
		elif set_recall.y == 0:
			instr.has_recall = false
	instr.start_move(tile)
	return instr.movements


func get_move(tile : Vector2i = Vector2i.ZERO) -> Array[Vector2i]:
	if current_instr:
		print_debug(current_instr.movements)
		return current_instr.movements
	elif tile == Vector2i.ZERO:
		build_instructions()
		return current_instr.movements
	else:
		return start_move(tile)


func record_move(tile : Vector2i,instr : Instructions = current_instr):
	var move = instr.movements
	if not move.has(tile):
		instr.add_move_target(tile)


func move_next():
	return current_instr.exe_move()


func receive_map(map_node : TileMapLayer,layer : MapLayers = MapLayers.MAIN):
#Structure of each dictionary entry should be 
#"[Layer]" : "tile_coord" : [(char_id,phys_layer),(atlas_coord)]

	var map_array = map_node.get_used_cells()
	var char_id : int
	var phys_layer : int
	var atlas_coord : Vector2i
	var parse_key : String = MapLayers.find_key(layer).capitalize()
	var foyer = map.get(parse_key,"tiles")
	var result
	for coord : Vector2i in map_array:
		char_id = map_node.get_cell_tile_data(coord).get_custom_data("Char_ID")
		phys_layer = map_node.tile_set.get_physics_layer_collision_layer(0)
		atlas_coord = map_node.get_cell_atlas_coords(coord)
		foyer[coord] = [Vector2i(char_id,phys_layer),atlas_coord]
