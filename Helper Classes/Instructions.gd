class_name Instructions extends Resource

@export var has_recall: bool = false
@export var movements : Array[Vector2i]
@export var actions : Array[Action]
@export_range(0,10) var timespan : float
@export var move_target : Vector2i
@export var current_tile : Vector2i

func add_move_target(tgt : Vector2i):
	movements.append(tgt)


func exe_move() -> Vector2i:
	if movements.is_empty():
		return Vector2i.ZERO
	else:
		move_target = movements.pop_front()
		return move_target


func start_move(start_tile : Vector2i = movements[0]):
	if has_recall:
		if movements.has(start_tile):
			var ind : int = movements.find(start_tile)
			if ind > 0: movements.pop_at(ind)
	else: movements.clear()
	movements.push_front(start_tile)


func register_current_tile(tile : Vector2i):
	current_tile = tile
