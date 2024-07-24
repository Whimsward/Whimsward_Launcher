class_name PlayerMovementData
extends Resource
##Serves as a class to define variables for movement of characters 
##directed by the player or relative to their avatar.##


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_group("Motion")
@export var speed : float = clampf(100,10,500)
#rename to jump_impulse
@export var jump_velocity : float = clampf(-250,-500,-10)
#deprecate on re-factor
@export var max_jump_height : float = clampf(400,10,1200)
@export var acceleration : float = clampf(150,10,450)
@export var friction : float = clampf(200,50,800)

@export_group("Gravity")
@export var has_gravity = true
@export var gravity_scale : float = clampf(1,.1,2)
@export var grav_mod : float = clampf(.5,.1,1)

var data_store : Dictionary = {
	"speed" : [speed, 10, 500],
	"jump_velocity" : [jump_velocity, -500, -10],
	"acceleration" : [acceleration, 10,450],
	"friction" : [friction,50,800],
	"has_gravity" : [has_gravity,false,true],
	"gravity_scale" : [gravity_scale,.1,2],
	"grav_mod" : [grav_mod,.1,1]
}
