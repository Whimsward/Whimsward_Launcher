extends Node

@onready var status = $"../../GridContainer/MovingAtkInd"
@onready var anim = $"../../Sprite2D/StickAnimTest"

func Enter():
	status.show()
	anim.play("attackwalk")
	pass
	
func Exit():
	status.hide()
	pass

