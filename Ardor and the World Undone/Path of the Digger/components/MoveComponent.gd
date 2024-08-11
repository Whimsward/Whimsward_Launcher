class_name MoveComponent extends Component

var grav = Vector2(0, ProjectSettings.get_setting("physics/2d/default_gravity"))

enum Moves {IDLE,WALK,RUN,SLIDE,DODGE} #lateral
@export var move_state : Moves

enum Air {GROUND,FALL,JUMP,SLIDE,FLY} #vertical
@export var air_state : Air

@export var vel : Vector2
@export var direction : Vector2 = Vector2.ZERO
@export var acceleration : int
@export var friction : int
@export var max_speed : int
@export var jump_strength : int

var jumps_available : int = 1
var max_jumps = 2

#TODO: Try to set up the math so that acceleration represents seconds to reach max speed.
func accelerate(velocity : Vector2) -> Vector2:
	if air_state == Air.FALL:
		vel.x = move_toward(velocity.x,direction.x * max_speed,acceleration)
		vel.y = move_toward(velocity.y,grav.y,friction)
	else:
		vel = velocity.move_toward(direction * max_speed, acceleration)
	return vel

func decelerate(velocity: Vector2) -> Vector2:
	if air_state == Air.FALL:
		vel.x = move_toward(velocity.x,0,friction)
		vel.y = move_toward(velocity.y,grav.y,friction)
	elif air_state == Air.JUMP:
		vel.x = move_toward(velocity.x,0,friction)
	else:
		vel = velocity.move_toward(Vector2.ZERO,friction)
	return vel


func jump(velocity : Vector2):
	if jumps_available > 0:
		accelerate(velocity + Vector2(0,- jump_strength))
		air_state = Air.JUMP
		jumps_available = clampi(jumps_available -1,0,max_jumps)


func recover_jumps():
	jumps_available = max_jumps
