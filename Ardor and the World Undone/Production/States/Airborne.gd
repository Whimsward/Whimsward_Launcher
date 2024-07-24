@icon("res://Assets/Resources/Art/Sprite sheet/WindySpriteButton smaller.png")
extends Node

var g_scale : float
var slowed : bool
var height_change : int
var start_pos : Vector2

func Enter():
#	print("Entered Airborne")
	#g_scale = player.movement_data.gravity_scale
	#start_pos = player.position
	pass
	
func Exit():
	if slowed == true:
		end_slow_fall()

	pass
	
func Update(_delta):
	pass

func Physics_Update(delta):
	#if player.is_on_floor():
		#to_state("grounded")
	pass
	#if not player.is_on_floor():
		#@warning_ignore("narrowing_conversion")
		#height_change = player.position.distance_to(start_pos)

#reset player to start_pos
		#if height_change > 5000:
			#player.position = GameVendor.controls.instruct.actor_start
			#GameVendor.set("current_phase",1)
		#if GameVendor.current_phase == 1:
			#player.velocity.y = 0
		#elif GameVendor.current_phase == 0:
			#player.velocity.y += (player.gravity * player.movement_data.gravity_scale) * delta
			#pass
		
	#else:
		#return


func _unhandled_input(event):
	if event.is_action_pressed("Jump"):
		#if player.name == "Ardor":
			#to_state("fly")
#		if slowed == false:
#			slow_fall()
#		if slowed == true:
#			end_slow_fall()
#			to_state("jumping")
		pass
	if event.is_action_released("Jump"):
		if slowed == true:
			end_slow_fall()


func slow_fall():
	pass
	#if not player.is_on_floor():
			#player.movement_data.gravity_scale -= player.movement_data.grav_mod
			#print("Slow Fall: ",player.movement_data.gravity_scale)
			#slowed = true


func end_slow_fall():
	slowed = false
	#player.movement_data.gravity_scale = g_scale
	print("Ended Slow Fall")
