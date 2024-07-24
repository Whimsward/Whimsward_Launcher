@icon("res://Assets/Resources/Art/Sprite sheet/WindySpriteButton smaller.png")
extends Node

var to_state : String


func Enter():
	print("Entered Active")
	get_tree().set_pause(false)
	pass
	
func Exit():
	print("Pass to ",to_state)
	pass
	
func Update(_delta):
	pass

func Physics_Update(_delta):
	if Input.is_action_just_pressed("Tap"):
		to_state = "turnselection"
		#transitioned.emit(self,to_state)
	pass

