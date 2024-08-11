extends TileMapLayer

var start : Color
var grid_scale
var viewport_size:
	set(value):
		viewport_size = value
		grid_scale = round(value / 10)
var cursor = tile_set.get_pattern(2)
var anti_cursor = tile_set.get_pattern(1)


@export var encounter : Encounter
@export var current_sel : Vector2i

func _ready():
	start = modulate
	viewport_size = get_viewport().size
	print_debug(grid_scale)
	#tile_set.tile_size = Vector2(grid_scale.x,grid_scale.x)
	#tile_set.get_source(0).texture_region_size = tile_set.tile_size + Vector2i(1,1)
	populate(10,Vector2i(0,0))
	print_debug(encounter.map)
	hide()


func invalid():
	var blinker = create_tween()
	blinker.tween_property(self,"modulate",Color.FIREBRICK,0.05)
	blinker.tween_property(self,"modulate",start,0.01)


func populate(grid_size : int,start_pos : Vector2i): ##Generate a grid array
	for x in grid_size:
		for y in grid_size:
			var current_pos = start_pos + Vector2i(x - 1,y -1)
			set_cell(current_pos,0,Vector2i(11,0))
	encounter.receive_map(self,Encounter.MapLayers.ENCOUNTER)


func get_current() -> TileData:
	return get_cell_tile_data(current_sel)


func get_move_request(dir : Vector2) -> Vector2i:
	var direction : TileSet.CellNeighbor
	if dir == Vector2.RIGHT:
		direction = TileSet.CellNeighbor.CELL_NEIGHBOR_RIGHT_SIDE
	elif dir == Vector2.LEFT:
		direction = TileSet.CellNeighbor.CELL_NEIGHBOR_LEFT_SIDE
	elif dir == Vector2.UP:
		direction = TileSet.CellNeighbor.CELL_NEIGHBOR_TOP_SIDE
	elif dir == Vector2.DOWN:
		direction = TileSet.CellNeighbor.CELL_NEIGHBOR_BOTTOM_SIDE
	var target = get_neighbor_cell(current_sel,direction)
	return target


func track_move(tile := current_sel):
	var move : Array[Vector2i]
	if not encounter.current_instr:
		move = encounter.start_move(tile)
	else: 
		move = encounter.get_move(tile)
		if not move.has(tile):
			encounter.record_move(tile,encounter.current_instr)
	return move


func place_sel_cursor(at : Vector2i): ##Paints "at" and the cell above and below it.
	#set_pattern(get_neighbor_cell(at,TileSet.CELL_NEIGHBOR_TOP_SIDE),cursor)
	set_cell(at,0,Vector2i(9,0))
	current_sel = at
	return get_current()


func process_move(target : Vector2i,location : Vector2i):
	if location == target or get_surrounding_cells(target).has(location):
		return true
	else: return false
