extends Node

@onready var status = $"../../GridContainer/WalkInd"
@onready var anim = $"../../Sprite2D/StickAnimTest"
@onready var player = owner

func Enter():
	status.show()
	anim.play("idlewalk")
	pass
	
func Exit():
	status.hide()
	pass

func Physics_Update(_delta):
	if Input.is_action_just_pressed("Jump"):
		pass
		#transitioned.emit(self,"jump")
	if player.direction == 0:
		pass
		#transitioned.emit(self,"idle")
