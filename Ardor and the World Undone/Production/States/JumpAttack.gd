extends Node

@onready var status = $"../../GridContainer/JumpAtkInd"
@onready var anim = $"../../Sprite2D/StickAnimTest"
@onready var player = owner

func Enter():
	status.show()
	anim.play("attackjump")
	pass
	
func Exit():
	status.hide()
	pass

func Physics_Update(_delta):
	if player.is_on_floor():
		#transitioned.emit(self,"attack")
		pass
