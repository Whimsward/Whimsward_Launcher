class_name TargetComponent extends Component

@export var target : CharacterBody2D
enum behavior {PASSIVE, ALERT, ATTACK}
@export var state : behavior
@export var in_range : bool = false

func _process(_delta):
	if target:
		if not is_in_range():
			state = behavior.ALERT
		else:
			state = behavior.ATTACK


func is_in_range() -> bool:
	return in_range
