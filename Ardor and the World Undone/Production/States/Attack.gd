extends Node

@export var pal : CharacterBody2D

@export var spdmod : float = 1.5
var move_direction : Vector2
var player : CharacterBody2D
var target : Marker2D
var guide
var direction
var duration : SceneTreeTimer

func Enter():
	print("\nEntered Attack State")
	player = get_tree().get_first_node_in_group("player")
	guide = get_tree().get_first_node_in_group("guide")
	target = get_tree().get_first_node_in_group("marker")
	guide.look_at(Vector2(100,0))


func Exit():
	pass


func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	
	if guide.is_colliding():
		print("Guide collide")
		move_direction = guide.get_collision_point()
		direction = move_direction - pal.global_position
	else: 
		move_direction = Vector2(guide.target_position.x,guide.target_position.y)
		direction = move_direction - pal.position
	pal.velocity = (direction / 6 ) * pal.MovementData.speed
	if pal.get_last_slide_collision():
		print("Pal hit something")
		#transitioned.emit(self,"idle")
	if direction.length() < 3:
		print("Pal went far enough")
		#transitioned.emit(self, "idle")
	if Input.is_action_just_pressed("Summon Pal"):
		print("Summoned Pal.")
		#transitioned.emit(self,"follow")
