@icon("res://Assets/Resources/Art/Sprite sheet/WindySpriteButton smaller.png")
extends Node

var start_pos
var current_pos
var height_change : float
var max_jump
var min_jump
var sigjump : bool
var vel

func Enter():
	#start_pos = player.position
	#max_jump = player.movement_data.max_jump_height
	min_jump = max_jump/4
	pass


func Exit():
	pass


func Update(_delta):
	pass


func Physics_Update(_delta):
	pass
	#current_pos = player.position
	#if GameVendor.current_phase == 0:
		
		
		#jump_math()
	#else:
		#to_state("airborne")


#reference player.movement_data.max_jump_height for when to force transition
#to airborne instead of jump_duration
func jump_math():
	height_change = current_pos.distance_to(start_pos)
	sigjump = Input.is_action_pressed("Jump")
	
	##if not sigjump and height_change > min_jump:
		#to_state("airborne")
#
	#if sigjump or height_change < min_jump:
		#player.velocity.y = player.movement_data.jump_velocity
#
	#if height_change > max_jump:
		#to_state("airborne")
	pass
