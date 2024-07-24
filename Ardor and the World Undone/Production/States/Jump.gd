extends Node

@export var player : CharacterBody2D
@onready var status = $"../../GridContainer/JumpInd"
@onready var anim = $"../../Sprite2D/StickAnimTest"

func Enter():
	status.show()
	anim.play("idlejump")
	pass
	
func Exit():
	status.hide()
	pass


func Update(_delta):
	pass


func Physics_Update(_delta):
	if player.is_on_floor():
		pass
		#transitioned.emit(self,"idle")
	if Input.is_action_just_pressed("Attack"):
		pass
		#transitioned.emit(self,"jumpattack")
	pass
