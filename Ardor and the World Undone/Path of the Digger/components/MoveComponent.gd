class_name MoveComponent extends Component

@export var vel : Vector2
@export var direction : Vector2
@export var acceleration : int
@export var friction : int
@export var max_speed : int

#TODO: Try to set up the math so that acceleration represents seconds to reach max speed.
func accelerate(velocity : Vector2) -> Vector2:
	vel = velocity.move_toward(direction * max_speed, acceleration)
	return vel

func decelerate(velocity: Vector2) -> Vector2:
	vel = velocity.move_toward(Vector2.ZERO,friction)
	return vel
