class_name Move extends Action
##Is an action for character movement

var distance : int ##In Tiles
@export var vertical : bool = false

func provide_magnitude(spd : int):
	var magn = duration * distance / spd
	return magn
