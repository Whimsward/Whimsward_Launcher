class_name FieldEntity extends CharacterBody2D
##Covers Players, Foes, Attack Effects, and possibly some Obstacles but let's not get too crazy.

signal died

var dying : bool = false

func die():
	died.emit()
	queue_free()






func _on_mouse_entered():
	DisplayServer.cursor_set_shape(DisplayServer.CURSOR_POINTING_HAND)
