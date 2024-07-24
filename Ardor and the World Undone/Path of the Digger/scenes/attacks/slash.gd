extends Attack

@export var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if dying:
		die()


func _on_struck(body):
	if body is Foe:
		if modulate != Color.CYAN:
			modulate = Color.CYAN


func _on_timer_timeout():
	dying = true
