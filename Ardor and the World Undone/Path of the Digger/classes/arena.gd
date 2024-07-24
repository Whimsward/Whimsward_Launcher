class_name Arena extends Node2D
##Class for rooms where battles take place.

signal player_died

@export_file("*.tscn") var actor
@export var player : Actor
@export var spawn_comp : SpawnComponent
var spawn_points : Array[Marker2D]


# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn_comp:
		if actor:
			player = load(actor).instantiate()
			add_child(player)
			player.attacked.connect(_on_actor_attacked)
			player.died.connect(_on_actor_died)
			player.position = spawn_comp.player_spawn.position
		spawn_points = spawn_comp.spawn_points
		spawn_foes()


func spawn_foes():
	if spawn_comp.foe_count == 0:
		for mark in spawn_comp.spawn_points:
			var enemy = load(spawn_comp.foe_type)
			var guy = enemy.instantiate()
			guy.name = "Charger"+str(spawn_comp.spawn_points.find(mark))
			guy.position = mark.position
			guy.died.connect(_on_foe_died)
			add_child(guy)
			spawn_comp.foe_count += 1


func _on_actor_attacked(attack):
	attack.position = player.position
	add_child(attack)


func _on_actor_died():
	player_died.emit()


func _on_foe_died():
	spawn_comp.foe_count -= 1
