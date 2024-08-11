class_name Action extends Resource
##Resource to represent actions Characters can take during Encounters.

@export var name : String
@export var description : Thesis
@export var icon : Texture2D
@export var model : PackedScene

@export var valid_during : Array[Action]
@export var base_duration : float
@export var duration : float
