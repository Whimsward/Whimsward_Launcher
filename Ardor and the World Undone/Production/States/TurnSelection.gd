@icon("res://Assets/Resources/Art/Sprite sheet/WindySpriteButton smaller.png")
extends Node

var timer : SceneTreeTimer
var world_color : Color
@onready var world : CanvasItem = owner

func Enter():
	#check_print_choice("Entered Turn Selection")
	timer = get_tree().create_timer(2,true,false,false)
	get_tree().set_pause(true)
	pass
	
func Exit():
	#check_print_choice("Pass to "+next_state)
	pass
	
func Update(_delta):
	if Input.is_action_just_pressed("Tap"):
		to_state("active")
	pass

func Physics_Update(delta):
	pass


#override base state's to_state() to include waiting out the timer
func to_state(a_state : String):
	#next_state = a_state
	#check_print_choice("Awaiting timeout")
	await timer.timeout
	#check_print_choice("Time In")
	#transitioned.emit(self,next_state)
