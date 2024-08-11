class_name FieldEntity extends CharacterBody2D
##Covers Players, Foes, Attack Effects, and possibly some Obstacles (but let's not get too crazy).

signal died(entity)

@export_range(0,10,1) var move_speed

var char_id : int
var dying : bool = false

func die():
	died.emit(self)
	queue_free()
