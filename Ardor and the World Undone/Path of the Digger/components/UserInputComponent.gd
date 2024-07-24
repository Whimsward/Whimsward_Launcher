class_name UserInputComponent extends Component

signal directed(direction: Vector2)

var left = "left"
var right = "right"
var up = "up"
var down = "down"
var move_inputs = [left,right,up,down]
var direction : Vector2 = Vector2.ZERO

func _unhandled_input(event):
	if event.is_action_type():
		direction = get_direction_input()
	directed.emit(direction)


func get_direction_input():
	var result = Input.get_vector(left,right,up,down)
	return result
