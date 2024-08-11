class_name UserInputComponent extends Component
##This Component signals specified user inputs to objects connected to those signals.
#NOTICE - This is currently placed as a child of an Actor node in order to signal directions
#up to the actor. Should it instead be placed as a child of a Game node so that the Game node
#can parse those signals and hand down commands appropriately according to the current state?

signal v_directed(direction: Vector2)
signal directed(direction: Vector2)
signal clicked_at(location : Vector2,prim : bool)

var left = "Left"
var right = "Right"
var up = "Up"
var down = "Down"
var move_inputs = [left,right,up,down]
var direction : Vector2 = Vector2.ZERO


func _process(_delta):
	directed.emit(Vector2(lateral_direction(),0))
	v_directed.emit(Vector2(0,vertical_direction()))


func get_direction_input():
	var result = Input.get_vector(left,right,up,down)
	return result
	

func lateral_direction():
	var result = Input.get_axis(left,right)
	return result


func vertical_direction():
	var result = Input.get_axis(up,down)
	return result
