@icon("res://Assets/Resources/Art/Sprite sheet/WindySpriteButton smaller.png")
extends Node

var vert : float

func Enter():
	#check_print_choice("AeroNav Entered")
	#vert = player.velocity.y
	pass
	
func Exit():
	#check_print_choice("End Aero Nav, to "+next_state)
	pass
	
func Update(_delta):
	pass

func Physics_Update(_delta):
	#if not abs(player.position.distance_to(player.target_region)) < 5:
		#if player.position.y > player.target_region.y:
			#vert = move_toward(vert,- player.movement_data.jump_velocity,player.target_region.y)
#
	#if player.check_nav == false:
		#to_state("airborne")

	pass

