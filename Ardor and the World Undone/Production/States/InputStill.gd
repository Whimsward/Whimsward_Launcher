@icon("res://Assets/Resources/Art/Sprite sheet/WindySpriteButton smaller.png")
extends Node


var direction

@onready var aerial_state = $"../../AerialStateMachine"

#update visual indicator of state?
func Enter():
	#direction = player.velocity.normalized().x
	print(direction)
	
	pass


func Exit():
	pass


#functions requiring constant updates that should not occur on the physics update
func Update(_delta):
	pass


func Physics_Update(_delta):
	#if GameVendor.current_phase == 1:
		#player.velocity.x = 0
	#elif GameVendor.current_phase == 0 or GameVendor.current_phase == 2:
		#if abs(player.velocity.x) > 0:
			#player.velocity.x = move_toward(player.velocity.x,0,player.movement_data.friction)
	
		if Input.is_action_just_pressed("Right") or Input.is_action_just_pressed("Left"):
#			if not aerial_state.current_state == "airborne":
			#to_state("movedirection")
#			else:
#				print("Can't start move in air")
			pass



func _on_actor_move_prompted(_target_region):
	pass
