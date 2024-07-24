class_name SpawnComponent extends Component

@export_file("*.tscn") var foe_type
@export var foe_count : int = 0
@export var spawn_points : Array[Marker2D]
@export var player_spawn : Marker2D


func _ready():
	pass
