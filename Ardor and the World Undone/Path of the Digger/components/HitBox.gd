class_name HitBox extends Area2D
##Use to register when something hits a [FieldEntity].


func _physics_process(_delta):
	if not visible:
		monitoring = false
	else : monitoring = true
