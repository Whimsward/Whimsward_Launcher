extends Node

var pal : CharacterBody2D
var player: CharacterBody2D
var target : Marker2D
var idle_zone : Area2D

func Enter():
	print("Entered Follow State")
	player = get_tree().get_first_node_in_group("player")
	target = get_tree().get_first_node_in_group("marker")
	pal = get_tree().get_first_node_in_group("pal")
	idle_zone = get_tree().get_first_node_in_group("idle_zone")
#	pal.guide.look_at(player.global_position)


func Exit():
	pass


func Update(_delta: float):
	pass


func Physics_Update(_delta: float):
	var direction = target.global_position - pal.global_position
#	var direction_x = target.global_position.x - pal.global_position.x
	if direction.length() > 15:
		pal.velocity = direction.normalized() * pal.MovementData.speed
	
	on_player_attacking(direction)
	
	if idle_zone.overlaps_body(pal):
		#transitioned.emit(self, "idle")
		pass


func on_player_attacking(direction):
	if Input.is_action_just_pressed("Attack"):
		if direction.length() < 30:
			#transitioned.emit(self,"attack")
			pass
		else: 
			return
