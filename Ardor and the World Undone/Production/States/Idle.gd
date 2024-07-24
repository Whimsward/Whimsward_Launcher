extends Node

@export var pal : Node2D
@export var movement_data: Resource
var player: CharacterBody2D
var target : Marker2D
var move_direction : Vector2
var wander_time : float
var idle_zone : Area2D


func Enter():
	print("Entered Idle State")
	player = get_tree().get_first_node_in_group("player")
	target = get_tree().get_first_node_in_group("marker")
	idle_zone = get_tree().get_first_node_in_group("idle_zone")
#	pal.guide.look_at(player.global_position)
	randomize_wander()


func Exit():
	pass

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else: randomize_wander()
	pass

func Physics_Update(_delta: float):
	var direction : Vector2 = target.global_position - pal.global_position

	pal.velocity = direction * (movement_data.speed / 2)
	
	if idle_zone.overlaps_body(pal) != true:
		#transitioned.emit(self,"follow")
		pass
	_on_player_attacking()


func randomize_wander():
	move_direction = Vector2(0,-1)
	wander_time = randf_range(1,3)


func _on_player_attacking():
	if Input.is_action_just_pressed("Attack"):
		pass
		#transitioned.emit(self,"attack")
